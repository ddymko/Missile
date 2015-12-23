#!/usr/bin/env ruby
require 'thor'
require 'yaml'
require 'net/scp'
require_relative "lib/list"
require_relative 'lib/setup'

class Missile < Thor

  @@file_path = File.expand_path(File.dirname(__FILE__)) + "/configs"

  desc 'setup [project_name]', 'creates a config file for a specific deployment'
  option :d, :type => :boolean , :desc => "Deletes specified project"
  def setup(project)

    project_dir =  @@file_path + '/' + project + '.yaml'
    if options[:d]
      Setup.delete(project_dir)
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

  ## List actions
  desc 'list', 'Displays available deployments'
  option :i, :type => :boolean , :desc => "[project name] -i Displays information about specific deployment setup "
  def list(project="")
    project = @@file_path + "/" + project + ".yaml"
    options[:i] ?  List.info(project) : List.list_all(@@file_path)
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
