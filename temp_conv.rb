#!/usr/bin/env ruby

require 'gtk4'

require_relative 'setup_builder'

$APPLICATION_ID  =   "info.rulie.motoakira.temp_conv"

application = Gtk::Application.new($APPLICATION_ID, :default_flags)
application.signal_connect("activate") { |app|
    window = setup_builder(app)
    window.set_application(app)
    window.show
}
status = application.run

puts status
