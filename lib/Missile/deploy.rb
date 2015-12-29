class Deploy

  def self.deploy(project_dir)
    config = YAML.load_file(project_dir)
    puts 'starting deployment'
    Net::SCP.upload!(config[:host], config[:username],
                     config[:local_path], config[:web_path],
                     :ssh => {:password => config[:password]},
                     :recursive => true)

    puts 'deployment complete'
  end

end
