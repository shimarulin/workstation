#!/usr/bin/env zsh
# https://github.com/larkery/zsh-histdb/blob/master/sqlite-history.zsh

zmodload zsh/datetime # for EPOCHSECONDS
zmodload zsh/system # for sysopen
builtin which sysopen &>/dev/null || return; # guard against zsh older than 5.0.8.

zmodload -F zsh/stat b:zstat # just zstat
autoload -U add-zsh-hook

HISTDB_FILE="../../roles/zsh/files/home/.local/share/histdb/zsh-history.db"

typeset -g HISTDB_INODE=()
typeset -g HISTDB_SESSION=""
typeset -g HISTDB_HOST=""
typeset -g HISTDB_INSTALLED_IN="${(%):-%N}"

_histdb_query () {
    sqlite3 -batch -noheader -cmd ".timeout 1000" "${HISTDB_FILE}" "$@"
    [[ "$?" -ne 0 ]] && echo "error in $@"
}

_histdb_start_sqlite_pipe () {
    local PIPE==(<<<'')
    setopt local_options no_notify no_monitor
    mkfifo $PIPE
    sqlite3 -batch -noheader "${HISTDB_FILE}" < $PIPE >/dev/null &|
    sysopen -w -o cloexec -u HISTDB_FD -- $PIPE
    command rm $PIPE
    zstat -A HISTDB_INODE +inode ${HISTDB_FILE}
}

_histdb_query_batch () {
    local CUR_INODE
    zstat -A CUR_INODE +inode ${HISTDB_FILE}
    if [[ $CUR_INODE != $HISTDB_INODE ]]; then
        _histdb_stop_sqlite_pipe
        _histdb_start_sqlite_pipe
    fi
    cat >&$HISTDB_FD
    echo ';' >&$HISTDB_FD # make sure last command is executed
}

_histdb_init () {
    if ! [[ -e "${HISTDB_FILE}" ]]; then
        local hist_dir="${HISTDB_FILE:h}"
        if ! [[ -d "$hist_dir" ]]; then
            mkdir -p -- "$hist_dir"
        fi
        _histdb_query <<-EOF
create table commands (id integer primary key autoincrement, argv text, unique(argv) on conflict ignore);
create table places   (id integer primary key autoincrement, host text, dir text, unique(host, dir) on conflict ignore);
create table history  (id integer primary key autoincrement,
                       session int,
                       command_id int references commands (id),
                       place_id int references places (id),
                       exit_status int,
                       start_time int,
                       duration int);
PRAGMA user_version = 2;
EOF
    fi

    _histdb_start_sqlite_pipe
    _histdb_query_batch >/dev/null <<EOF
create index if not exists hist_time on history(start_time);
create index if not exists place_dir on places(dir);
create index if not exists place_host on places(host);
create index if not exists history_command_place on history(command_id, place_id);
PRAGMA journal_mode = WAL;
PRAGMA synchronous=normal;
EOF
}

_histdb_init
