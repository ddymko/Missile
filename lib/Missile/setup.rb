class Setup

  def self.delete(project)
    response = "#{project} was sucessfully deleted"
    File.exist?(project) ? File.delete(project) : response = "File does not exist"
    puts response
  end

  def self.create(project_dir)

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
    print 'Please enter port number (leave blank if default)'
    port = STDIN.gets.chomp

    port = port.nil? ? port : '22'

    configs = {:host => host, :username => username, :password => password, :web_path => web_path, :local_path => local_path, :port => port}
    File.open(File.expand_path(project_dir), 'w+') { |file| file.write(configs.to_yaml) }
  end

end
