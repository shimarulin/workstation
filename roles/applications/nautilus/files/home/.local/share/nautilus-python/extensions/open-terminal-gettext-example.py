import os, locale

try:
    from urllib import unquote
except ImportError:
    from urllib.parse import unquote

from gi import require_version
require_version('Gtk', '3.0')
require_version('Nautilus', '3.0')

from gi.repository import Nautilus, GObject
from gettext import gettext, bindtextdomain, textdomain

TERMINAL_PATH="/usr/bin/termite"

class NautilusOpenInTerminal(GObject.GObject, Nautilus.MenuProvider):
	"""Open in terminal"""
	def __init__(self):
		GObject.Object.__init__(self)

	def get_background_items(self, window, file):
		"""Returns the menu items to display when no file/folder is selected
		(i.e. when right-clicking the background)."""

		# Add the menu items
		items = []
		self._setup_gettext();
		self.window = window
		if file.is_directory() and file.get_uri_scheme() == "file":
			if os.path.exists(TERMINAL_PATH):
				items += [self._create_terminal_item(file)]

		return items


	def _setup_gettext(self):
		"""Initializes gettext to localize strings."""
		try: # prevent a possible exception
			locale.setlocale(locale.LC_ALL, "")
		except:
			pass
		bindtextdomain("nautilus-open-in-terminal", "/usr/share/locale")
		textdomain("nautilus-open-in-terminal")

	def _create_terminal_item(self, file):
		"""Creates the 'Open in Terminal' menu item."""
		item = Nautilus.MenuItem(name="NautilusOpenInTerminal::Nautilus",
		                         label=gettext("Open in T_erminal"),
		                         tip=gettext("Open this folder in the terminal"))
		item.connect("activate", self._terminal_run, file)
		return item


	def _terminal_run(self, menu, file):
		"""'Open in Terminal' menu item callback."""
		filename = unquote(file.get_uri()[7:])
		os.chdir(filename)
		os.system(TERMINAL_PATH + " &")
