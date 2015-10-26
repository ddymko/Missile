#!/usr/bin/env ruby
require 'thor'
require 'yaml'
require 'net/scp'


class Missile < Thor

  desc 'setup PROJECT_NAME', 'creates a config file for a specific deployment'
  option :d, :type => :boolean

  def setup(project)
    if options[:d]
      puts 'deleting...'
    else
      puts 'Please enter your host >'
      host = STDIN.gets.chomp
      puts 'Please enter your username >'
      username = STDIN.gets.chomp
      puts 'Please enter your password >'
      password = STDIN.gets.chomp
      puts 'Please enter web path to project'
      web_path = STDIN.gets.chomp
      puts 'Please enter local path to project'
      local_path = STDIN.gets.chomp
      configs = {:host => host, :username => username, :password => password, :web_path => web_path, :local_path => local_path}
      project =  Dir.pwd + '/configs/' + project + '.yaml'
      File.open(File.expand_path(project), 'w+') { |file| file.write(configs.to_yaml) }
    end
  end

  desc 'deploy PROJECT_NAME', 'this will start a deplyoment for the specifiied project'
  def deploy(project)

    project =  '/configs/' + project + '.yaml'
    config = YAML.load_file(File.join(__dir__, project ))
    Net::SCP.upload!(config[:host], config[:username],
                     config[:local_path], config[:web_path],
                     :ssh => {:password => config[:password]}, :recursive => true)
  end
end
Missile.start(ARGV)
