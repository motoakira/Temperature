require_relative('Temperature')

def setup_builder(app)
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
    window = builder.get_object("window")
    window.signal_connect("destroy") do
        app.quit
    end
    window.signal_connect("close-request") do
        app.quit
    end

    grid = builder.get_object("grid")

    button = builder.get_object("CtoF")
    button.signal_connect("clicked") { ctof }

    button = builder.get_object("FtoC")
    button.signal_connect("clicked") { ftoc }

    button = builder.get_object("quit")
    button.signal_connect("clicked") { app.quit }

    @c_entry = builder.get_object('celsius')
    @f_entry = builder.get_object("fahrenheit")
    @k_entry = builder.get_object("kelvin")

    @text_area = builder.get_object("text_area")

    return window
end

def ctof
    buffer = @text_area.buffer
    buffer.set_text("")
    c_temp = Temperature.new(@c_entry.text.to_f, :C)
    begin
        c_temp.validate!
        f_temp = c_temp.to_fahrenheit
        f_temp.validate!
        @f_entry.text = f_temp.value.to_s
        k_temp = c_temp.to_kelvin
        k_temp.validate!
        @k_entry.text = k_temp.value.to_s
    rescue => e
        buffer.set_text(e.message)
        @f_entry.text = ""
        @k_entry.text = ""
    end
end

def ftoc
    buffer = @text_area.buffer
    buffer.set_text("")
    f_temp = Temperature.new(@f_entry.text.to_f, :F)
    begin
        f_temp.validate!
        c_temp = f_temp.to_celsius
        c_temp.validate!
        @c_entry.text = c_temp.value.to_s
        k_temp = c_temp.to_kelvin
        k_temp.validate!
        @k_entry.text = k_temp.value.to_s
    rescue => e
        buffer.set_text(e.message)
        @c_entry.text = ""
        @k_entry.text = ""
    end
end
