#!/usr/bin/env ruby
require 'thor'
require 'yaml'
require 'net/scp'
require_relative 'lib/list'
require_relative 'lib/setup'
require_relative 'lib/deploy'

class Missile < Thor

  @@file_path = File.expand_path(File.dirname(__FILE__)) + "/configs"

  desc 'setup [project_name]', 'creates a config file for a specific deployment'
  option :d, :type => :boolean , :desc => "Deletes specified project"
  def setup(project)
    project_dir =  @@file_path + '/' + project + '.yaml'
    options[:d] ? Setup.delete(project_dir) : Setup.create(project_dir)
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
    project_dir =  @@file_path + '/' + project + '.yaml'
    Deploy.deploy(project_dir)
  end
end
Missile.start(ARGV)
