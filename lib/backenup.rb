
require 'set'
require 'grit'
require 'fileutils'

module Backenup

  class Storage
    attr_reader :base_path
    
    def initialize(base_path)
      @base_path = File.absolute_path(base_path)
      
      @repo = File.exists?(base_path) ? Grit::Repo.new(base_path) : Grit::Repo.init(base_path)
    end
    
    def storage_path
      File.join(self.base_path, "storage")
    end
    
    # Convenient way to see the contents of the storage
    def ls(path = ".")
      make_storage_path_exist
      Dir.entries(File.join(self.storage_path, path)).reject{|f| [".", ".."].include? f}
    end
    
    
    def cp(src, dest = nil)
      if dest.nil?
        dest = File.basename(src)
      end
      
      dest = File.join(self.storage_path, dest)
      
      make_storage_path_exist
      FileUtils.cp_r src, dest
    end


    # Clears the current contents of the storage.
    def clear
      self.ls.each do |f|
        FileUtils.rm_rf File.join(self.storage_path, f)
      end
    end


    def commit(message = nil)
      if message.nil?
        files = self.ls
        if files.any?
          message = "Storage:\n#{files.map{|f| '  ' + f}.join("\n") }"
        else
          message = "[No files in storage]"
        end
      end
      message = self.ls.join("\n") if message.nil?
      
      Dir.chdir self.base_path do
        @repo.add "."             # Add all new / modified files
        @repo.commit_all message  # This handles any file that was deleted
      end
    end
    
    
    private
    
    def make_storage_path_exist
      Dir.mkdir self.storage_path unless File.exists?(self.storage_path)
    end
    
  end
  
end

