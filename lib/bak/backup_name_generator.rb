module Bak
    class BackupNameGenerator
        attr_accessor :options, :filename

        def initialize(filename, options_hash)
            @filename = filename
            @options = options_hash
        end

        def [](item)
            @options[item]
        end

        def []=(k, v)
            @options[k] = v
        end

        def start
            filename = @filename
            if @options != {}
                if @options[:date] then filename = _with_date(filename) end
                if @options[:postfix] then filename = _with_postfix(filename, @options[:postfix]) end
                if @options[:prefix] then filename = _with_prefix(filename, @options[:prefix]) end
                if @options[:replace] then filename = _with_replace(filename, @options[:replace]) end
            end
            unless @options[:no_bak] then filename = "#{filename}.bak" end

            filename
        end

    private
        def _with_date(filename)
            return "#{filename}.#{_get_date}"
        end

        def _with_postfix(filename, postfix)
            return "#{filename}_#{postfix}"
        end

        def _with_prefix(filename, prefix)
            return "#{prefix}_#{filename}"
        end

        def _with_replace(filename, replace_info)
            pattern = replace_info[:pattern]
            replace = replace_info[:replace]
            return filename.gsub(pattern, replace)
        end

        def _get_date
            return Time.new.strftime("%Y-%m-%d")
        end
    end
end
