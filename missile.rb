#!/usr/bin/env ruby
require 'thor'
require 'yaml'
require 'net/scp'


class Missile < Thor

  @@file_path = File.expand_path(File.dirname(__FILE__)) + "/configs"

  desc 'setup PROJECT_NAME', 'creates a config file for a specific deployment'
  option :d, :type => :boolean
  def setup(project)

    project_dir =  Dir.pwd + '/configs/' + project + '.yaml'
    if options[:d]
      if File.exist?(project_dir)
        File.delete(project_dir)
        puts "#{project} was successfully deleted"
      else
        puts "File #{project} does not exist"
      end
    else
      print 'Please enter your host > '
      host = STDIN.gets.chomp
      print 'Please enter your username > '
      username = STDIN.gets.chomp
      print 'Please enter your password > '
      password = STDIN.gets.chomp
      print 'Please enter web path to project > '
      web_path = STDIN.gets.chomp
      print 'Please enter local path to project > '
      local_path = STDIN.gets.chomp
      configs = {:host => host, :username => username, :password => password, :web_path => web_path, :local_path => local_path}
      File.open(File.expand_path(project_dir), 'w+') { |file| file.write(configs.to_yaml) }
    end
  end

  desc 'list', 'will display available deployments'
  def list

    Dir.entries(@@file_path).each do |e|
      puts e.chomp('.yaml') if !File.directory?(e)
    end
  end

  desc 'deploy PROJECT_NAME', 'this will start a deployment for the specified project'
  def deploy(project)

    project =  '/configs/' + project + '.yaml'
    config = YAML.load_file(File.join(__dir__, project ))
    Net::SCP.upload!(config[:host], config[:username],
                     config[:local_path], config[:web_path],
                     :ssh => {:password => config[:password]},
                     :recursive => true)

    puts 'deployment complete'
  end
end
Missile.start(ARGV)
