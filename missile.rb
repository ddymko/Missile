#!/usr/bin/env ruby
APP_ROOT = File.dirname(__FILE__)
require 'thor'
require 'yaml'
require 'net/scp'
require File.join(APP_ROOT, 'lib', 'list')
require File.join(APP_ROOT, 'lib', 'setup')
require File.join(APP_ROOT, 'lib', 'deploy')


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
Missile.start(ARGV)
