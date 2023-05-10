#!/usr/bin/env ruby

require 'gtk4'

require_relative 'setup_builder'

$APPLICATION_ID  =   "info.rulie.motoakira.temp_conv"

def apply_css(window)
    provider = Gtk::CssProvider.new
    gfile = Gio::File.new_for_path("temperature.css")
    provider.load_from_file(gfile)
    Gtk::StyleContext.add_provider_for_display(window.display, provider, :user)
end

application = Gtk::Application.new($APPLICATION_ID, :default_flags)
application.signal_connect("activate") { |app|
    window = setup_builder(app)
    window.set_application(app)
    apply_css(window)
    window.show
}

status = application.run

puts status
