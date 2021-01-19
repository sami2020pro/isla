/* use the deps */
using GLib;
using Gdk;
using Gtk;
// using Hdy;
using Vte;

public class Isla {
    private Isla () {
        Gtk.Window window; /* The main window */
        Terminal terminal; /* The terminal */

        window = new Gtk.Window (Gtk.WindowType.TOPLEVEL); /* Create an instance from Gtk.Window */
        terminal = new Terminal (); /* Create an instance from Vte.Terminal */
        
        /* Load the SHELL for example zsh or fish */
        var command = GLib.Environment.get_variable ("SHELL");
        try {
			terminal.spawn_sync (
				Vte.PtyFlags.DEFAULT,
				null,                       /* Working directory */
				new string[] { command },   /* Command */
				null,                       /* Additional environment */
				0,                          /* Spawn flags */
				null,                       /* Child setup */
				null                        /* Child pid */
			);
		} catch (GLib.Error e) {
			stderr.printf (e.message); /* Panic the error message */
		}
        
        /* Work on the terminal */
        terminal.child_exited.connect ((t) => { Gtk.main_quit (); }); /* Quit from window */
        terminal.set_scrollback_lines ( 1000 ); /* Set scroll back lines */
        terminal.set_mouse_autohide ( true ); /* Set mouse autohide */

        /* Work on the window */
        window.add (terminal); /* Add isla terminal to main window */
        window.set_title ("Isla");
        window.window_position = Gtk.WindowPosition.CENTER; /* Set the window position to center */
        window.set_default_size (450, 300);
        window.set_resizable (true); /* Make window resizable to any size */
        window.set_decorated (true); /* Enable decorated */

        try {
            window.set_icon_from_file ("./assets/logo.png"); /* Load isla terminal logo from assets directory */
        } catch (Error e) {
            stderr.printf (e.message); /* Panic the error message */
        }

        window.show_all (); /* Show everything */
    }

    private void run () {
        Gtk.main (); /* Run the isla terminal */
    }

    private static int main (string[] args) {
        Isla terminal; /* Isla terminal */
        Gtk.init (ref args); /* Initialize args */
        terminal = new Isla (); /* Create an instance from Isla */
        terminal.run (); /* Run the isla terminal and show everything */
        
        return 0; /* Return 0 */
    }
}
