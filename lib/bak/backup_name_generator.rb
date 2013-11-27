class BackupNameGenerator
    attr_reader :options

    def initialize(filename, options_hash)
        @filename = filename
        @options = options_hash
    end

    def [](item)
        @options[item]
    end

    def start
        filename = @filename
        if @options != {}
            if @options[:date] then filename = _with_date(filename) end
            if @options[:postfix] then filename = _with_postfix(filename, @options[:postfix]) end
        else
            filename = _basic(filename)
        end
        unless @options[:no_bak] then filename = "#{filename}.bak" end

        filename
    end

private
    def _basic(filename)
        return "#{filename}"
    end

    def _with_date(filename)
        return "#{filename}.#{_get_date}"
    end

    def _with_postfix(filename, postfix)
        return "#{filename}_#{postfix}"
    end

    def _get_date
        return Time.new.strftime("%Y-%m-%d")
    end
end
