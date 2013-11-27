class BakFile
    def initialize(name)
        @name = name
    end

    def name
        @name
    end

    def exist?
        File.exist?(@name)
    end
end
