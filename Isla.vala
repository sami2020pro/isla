using Gtk;
using Vte;

public class Isla {

    private Isla () {
        Window window;
        Terminal terminal;

        window = new Window (Gtk.WindowType.TOPLEVEL);
        terminal = new Terminal ();
        
        terminal.child_exited.connect ((t) => { Gtk.main_quit (); });

        window.add (terminal);
        window.maximize ();
        window.set_decorated (false);

        try {
            window.set_icon_from_file ("./assets/logo.png");
        } catch (Error e) {
            stdout.printf (e.message);
        }

        window.show_all ();
    }

    private void run () {
        Gtk.main ();
    }

    private static void main (string[] args) {
        Isla terminal;
        Gtk.init (ref args);
        terminal = new Isla ();
        terminal.run ();
    }
}
