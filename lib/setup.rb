class Setup

  def self.delete(project)
    response = "#{project} was sucessfully deleted"
    File.exist?(project) ? File.delete(project) : response = "File does not exist"
    puts response
  end

end
