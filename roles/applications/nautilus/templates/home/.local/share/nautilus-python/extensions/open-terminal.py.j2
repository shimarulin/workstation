# This example is contributed by Martin Enlund
# https://gitlab.gnome.org/GNOME/nautilus-python/-/blob/master/examples/open-terminal.py
#
# Example modified for tilix
# https://github.com/gnunn1/tilix/blob/master/data/nautilus/open-tilix.py
# See also
#   - https://github.com/Stunkymonkey/nautilus-open-any-terminal/blob/master/nautilus_open_any_terminal/nautilus_open_any_terminal.py
#   - https://gist.github.com/LorenzoMorelli/45a3b59f225201def6479ec758da1af5
import os
from urllib.parse import unquote
from gi.repository import Nautilus, GObject
from typing import List


class OpenTerminalExtension(GObject.GObject, Nautilus.MenuProvider):
    def _open_terminal(self, file: Nautilus.FileInfo) -> None:
        filename = unquote(file.get_uri()[7:])

        os.chdir(filename)
        os.system("{{ nautilus_terminal_emulator_executable_command }}")

    def menu_activate_cb(
        self,
        menu: Nautilus.MenuItem,
        file: Nautilus.FileInfo,
    ) -> None:
        self._open_terminal(file)

    def menu_background_activate_cb(
        self,
        menu: Nautilus.MenuItem,
        file: Nautilus.FileInfo,
    ) -> None:
        self._open_terminal(file)

    def get_file_items(
        self,
        files: List[Nautilus.FileInfo],
    ) -> List[Nautilus.MenuItem]:
        if len(files) != 1:
            return []

        file = files[0]
        if not file.is_directory() or file.get_uri_scheme() != "file":
            return []

        item = Nautilus.MenuItem(
            name="NautilusPython::openterminal_file_item",
            label="Открыть в терминале",
            tip="Открыть терминал в %s" % file.get_name(),
        )
        item.connect("activate", self.menu_activate_cb, file)

        return [
            item,
        ]

    def get_background_items(
        self,
        current_folder: Nautilus.FileInfo,
    ) -> List[Nautilus.MenuItem]:
        item = Nautilus.MenuItem(
            name="NautilusPython::openterminal_file_item2",
            label="Открыть терминал в этом каталоге",
            tip="Открыть терминал в %s" % current_folder.get_name(),
        )
        item.connect("activate", self.menu_background_activate_cb, current_folder)

        return [
            item,
        ]
