### zsh-autosuggestions (https://github.com/zsh-users/zsh-autosuggestions)
# https://github.com/larkery/zsh-histdb#integration-with-zsh-autosuggestions
# Query to find the most frequently issued command issued exactly in this directory,
# or if there are no matches it will find the most frequently issued command in any directory
_zsh_autosuggest_strategy_histdb_top() {
  local query="select commands.argv from
    history left join commands on history.command_id = commands.rowid
    left join places on history.place_id = places.rowid
    where commands.argv LIKE '$(sql_escape $1)%'
    group by commands.argv
    order by places.dir != '$(sql_escape $PWD)', count(*) desc limit 1"
  suggestion=$(_histdb_query "$query")
}

# https://www.dev-diaries.com/blog/terminal-history-auto-suggestions-as-you-type/
# Query to pull in the most recent command if anything was found similar
# in that directory. Otherwise pull in the most recent command used anywhere
# Give back the command that was used most recently
_zsh_autosuggest_strategy_histdb_top_most_recent() {
  local query="
  select commands.argv from
  history left join commands on history.command_id = commands.rowid
  left join places on history.place_id = places.rowid
  where places.dir LIKE
    case when exists(select commands.argv from history
    left join commands on history.command_id = commands.rowid
    left join places on history.place_id = places.rowid
    where places.dir LIKE '$(sql_escape $PWD)%'
    AND commands.argv LIKE '$(sql_escape $1)%')
      then '$(sql_escape $PWD)%'
      else '%'
      end
  and commands.argv LIKE '$(sql_escape $1)%'
  group by commands.argv
  order by places.dir LIKE '$(sql_escape $PWD)%' desc,
    history.start_time desc
  limit 1"
  suggestion=$(_histdb_query "$query")
}

#ZSH_AUTOSUGGEST_STRATEGY=histdb_top
ZSH_AUTOSUGGEST_STRATEGY=histdb_top_most_recent
