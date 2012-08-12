module Jstats
  
  class Loc

    attr_reader :tables
    
    def initialize(directories)
      @java_files = JavaParse::JavaFiles.new(directories)
      @distrib = {(0...100) => 0, (100...200) => 0, (200...300) => 0, (300...400) => 0, (400...500) => 0, (500...600) => 0, 
                      (600...700) => 0, (700...800) => 0, (800...900) => 0, (900...1000) => 0, (1000...5000) => 0 }
      run_distrib
      @tables = [total_lines_table, distribution_table]
    end
    
    private 
    
    def run_distrib
      @distrib_rows = []
      @java_files.each { |unit|
        @distrib.each_key { |range| 
          @distrib[range] = @distrib[range] + 1 if range.include? unit.all_lines
        }
      }
      
      @distrib.to_a.each { |d| @distrib_rows << d}

      @distrib_rows.each { |row|
        row.push(sprintf('%.1f', (row[1] * 100) / (@java_files.count).to_f) + ' %')
      }
    end
    
    def distribution_table
      Terminal::Table.new :title => "Files size distribution", 
                          :headings => ['Lines range', 'Files in range', '  % ' ], 
                          :rows => @distrib_rows
    end

    def total_lines_table
      Terminal::Table.new :title => "Processing #{@java_files.count} Java Files", 
                          :headings => ['All lines', 'Lines of code', 'Lines of comments', 'Blank lines' ], 
                          :rows => [[@java_files.count(:all_lines), @java_files.count(:loc), @java_files.count(:cloc), @java_files.count(:bloc)]]
    end
    
  end
  
end