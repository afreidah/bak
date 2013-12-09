class FileCopier
    attr_accessor :generator, :start_file, :end_file
    def initialize(backupNameGenerator, output_stream)
        @generator = backupNameGenerator
        @output = output_stream
        @start_file = @generator.filename
        @end_file = @generator.start
    end

    def check_errors
        unless File.exists?(@start_file)
            return "#{start_file}: No such file or directory"
        end
        if File.exists?(@end_file) && !@generator[:force]
            return "#{end_file}: File already exists"
        end
    end

    def start
        errors = check_errors
        if errors
            @output.puts errors
        else
            FileUtils.cp_r(start_file, end_file)
        end
    end
end
