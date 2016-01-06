class List

  def self.list_all(file_path)
    if !(Dir.entries(file_path) - %w{. ..}).empty?
      Dir.entries(file_path).each do |e|
        puts e.chomp('.yaml') if !File.directory?(e)
      end
    else
      puts "There are no deployment files available"
    end
  end

  def self.info(project)
    if File.exist?(project)
        text = File.open(project)
        text.each_line do |line|
        end
    else
      puts "The deployment file you are looking for does not exist"
    end

  end

end
