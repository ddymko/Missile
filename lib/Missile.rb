require "Missile/version"
require 'thor'
require 'yaml'
require 'net/scp'
require_relative 'missile/list'
require_relative 'missile/setup'
require_relative 'missile/deploy'

module Missile
  class Missile < Thor

  @@file_path = File.expand_path(File.dirname(__FILE__)) + "/configs"

  desc 'setup [project_name]', 'creates a config file for a specific deployment'
  option :d, :type => :boolean , :desc => "Deletes specified project"
  def setup(project)
    options[:d] ? Setup.delete(project_path(project)) : Setup.create(project_path(project))
  end

  ## List actions
  desc 'list', 'Displays available deployments'
  option :i, :type => :boolean , :desc => "[project name] -i Displays information about specific deployment setup "
  def list(project="")
    puts @@file_path

    options[:i] ?  List.info(project_path(project)) : List.list_all(@@file_path)
  end

  desc 'deploy PROJECT_NAME', 'this will start a deployment for the specified project'
  def deploy(project)
    Deploy.deploy(project_path(project))
  end

  no_commands{
    def project_path(project)
      return project_dir =  @@file_path + '/' + project + '.yaml'
    end
  }
end
end
