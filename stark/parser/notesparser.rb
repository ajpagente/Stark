module Stark
  class NotesParser
 
    attr_reader :notes
    
    def initialize()
      @notes = ""
    end

    def parse(filename)
      @filename = filename
      @notes = File.read(@filename)
    end 
  end
end
