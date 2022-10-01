require_relative('Temperature')

def setup_builder
    #/* Construct a GtkBuilder instance and load our UI description */
    #builder = gtk_builder_new ();
    builder = Gtk::Builder.new
=begin
    if (gtk_builder_add_from_file (builder, "builder.ui", &error) == 0)
    {
        g_printerr ("Error loading file: %s\n", error->message);
        g_clear_error (&error);
        return 1;
    }
=end

    builder.add_from_file("builder.ui")

    #/* Connect signal handlers to the constructed widgets. */
    #window = gtk_builder_get_object (builder, "window");
    window = builder.get_object("window")
    #g_signal_connect (window, "destroy", G_CALLBACK (gtk_main_quit), NULL);
    window.signal_connect("destroy") do
        Gtk.main_quit
    end

    grid = builder.get_object("grid")
    #window.add(grid)

    #button = gtk_builder_get_object (builder, "button1");
    button = builder.get_object("CtoF")
    #g_signal_connect (button, "clicked", G_CALLBACK (print_hello), NULL);
    button.signal_connect("clicked") { ctof }
    #grid.add(button)

    #button = gtk_builder_get_object (builder, "button2");
    button = builder.get_object("FtoC")
    #g_signal_connect (button, "clicked", G_CALLBACK (print_hello), NULL);
    button.signal_connect("clicked") { ftoc }
    #grid.add(button)

    #button = gtk_builder_get_object (builder, "quit");
    button = builder.get_object("quit")
    #g_signal_connect (button, "clicked", G_CALLBACK (gtk_main_quit), NULL);
    button.signal_connect("clicked") { Gtk.main_quit }
    #grid.add(button)

    @c_entry = builder.get_object('celsius')
    @f_entry = builder.get_object("fahrenheit")

    window.show_all
end

def ctof
    c_temp = Temperature.new(@c_entry.text.to_f, :C)
    c_temp.validate!
    @f_entry.text = c_temp.to_fahrenheit.value.to_s
end

def ftoc
    f_temp = Temperature.new(@f_entry.text.to_f, :F)
    f_temp.validate!
    @c_entry.text = f_temp.to_celsius.value.to_s
end
