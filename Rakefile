# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'
require 'bundler'
Bundler.require

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'MapBoxRubyMotionExample'
  app.pods do
    pod 'NSData+Base64'
    pod 'MapBox'
  end

  # Force RubyMotion to recognise Proj4 as static library
  app.libs.delete_if { |lib| lib =~ /Proj4/ }
  app.vendor_project('vendor/Pods/MapBox/Proj4', :static, products: ['libProj4.a'])
end
