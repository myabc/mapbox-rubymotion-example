# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

IOS_EXAMPLE_DIR = '../mapbox-ios-example/MapBox\ Example'

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

desc 'Copy resources from MapBox iOS Example project'
task :copy_ios_example_resources do
end

# CocoaPods doesn't set this up for us
file 'resources/MapBox.bundle' => 'vendor/Pods/Resources/MapBox.bundle' do
  cp_r 'vendor/Pods/Resources/MapBox.bundle', 'resources/', :verbose => true
end

FileList["#{IOS_EXAMPLE_DIR}/*.{png,mbtiles}"].each do |source|
  target = source.pathmap('resources/%f')
  file target => source do
    cp source, target, :verbose => true
  end
  task :copy_ios_example_resources => target
end

%w(build:simulator build:device).each do |build_task|
  task build_task => 'resources/MapBox.bundle'
  task build_task => :copy_ios_example_resources
end
