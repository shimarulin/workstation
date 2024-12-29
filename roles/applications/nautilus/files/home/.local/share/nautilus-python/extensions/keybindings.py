import gi

gi.require_version("Nautilus", "4.0")
gi.require_version("Gtk", "4.0")
from gi.repository import GObject, Nautilus, Gtk

shortcut = "<Alt>Down"

def back():
    app = Gtk.Application.get_default()
    if not app.get_actions_for_accel(shortcut):
        app.set_accels_for_action("slot.up", [shortcut])

class Back(GObject.GObject, Nautilus.InfoProvider):
    def __init__(self):
        pass

    def update_file_info(self, file):
        back()
        return None
