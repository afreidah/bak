class FileCopier
    def initialize(name, backupNameGenerator)
        @generator = backupNameGenerator
        @start_file = BakFile.new(name)
        @end_file = BakFile.new(@generator.start)
    end

    def start_file
        @start_file.name
    end

    def end_file
        @end_file.name
    end

    def check_errors
        unless @start_file.exist?
            return "#{start_file}: No such file or directory"
        end
        if @end_file.exist? && !@generator[:force]
            return "#{end_file}: File already exists"
        end
    end

    def start
        errors = check_errors
        if errors
            STDERR.puts errors
        else
            FileUtils.cp_r(start_file, end_file)
        end
    end
end
