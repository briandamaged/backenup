
require 'set'
require 'grit'
require 'fileutils'

module Backenup

  class Store
    attr_reader :base_path
    
    def initialize(base_path)
      @base_path = File.absolute_path(base_path)
      
      if File.exists? base_path
        @repo = Grit::Repo.new(base_path)
      else
        @repo = Grit::Repo.init(base_path)
        Dir.mkdir self.storage_path
      end
      
    end
    
    def storage_path
      File.join(self.base_path, "storage")
    end
    
    # Convenient way to see the contents of the storage
    def ls(path = ".")
      Dir.entries(File.join(self.storage_path, path)).reject{|f| [".", ".."].include? f}
    end


    # Clears the current contents of the storage.
    def clear
      self.ls.each do |f|
        puts File.join(self.storage_path, f)
      end
    end
    
        
  end
  
end

