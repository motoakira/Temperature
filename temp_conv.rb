#!/usr/bin/env ruby

require 'gtk3'

require_relative 'setup_builder'

setup_builder()

status = Gtk.main

puts status
