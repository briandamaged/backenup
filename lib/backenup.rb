
require 'set'
require 'grit'
require 'fileutils'

module Backenup

  Reserved = Set.new([".", "..", ".git"])

  class Store
    attr_reader :repo, :path
    
    def initialize(repo)
      @repo = repo
      @path = File.dirname(repo.path)
    end
    
    
    # The files that are currently occupying the workspace
    def tenants
      return Set.new(Dir.entries(@path)) - Reserved
    end
    
    def clear
      
    end
    
  end
  
end

