require 'spec_helper'

describe "commandline options" do
    before(:each) do
        @file = "testfile.txt"
        @date = Time.new.strftime("%Y-%m-%d") 
        @generator = Bak::BackupNameGenerator.new(@file, {})
    end

    describe "name generation with the date method" do
        before(:each) do
            @date = Time.new.strftime("%Y-%m-%d")
            @generator[:date] = true
        end

        it "should append the date with the _with_date method" do
            @generator.send(:_with_date, @file).should == "#{@file}.#{@date}"
        end

        it "should append today's date and .bak to the fil with the start methode" do
            @generator.start.should == "#{@file}.#{@date}.bak"
        end
    end

    describe "name generation with the postfix method" do
        before(:each) { @generator[:postfix] = "test" }

        describe "default behavior" do
            it "should append _test with the _with_postfix method" do
                @generator.send(:_with_postfix, @file, "test").should == "#{@file}_test"
            end

            it "should append _test.bak to the end of the file with the start method" do
                @generator.start.should == "#{@file}_test.bak"
            end
        end

        describe "with the no_bak option as well" do
            before(:each) { @generator[:no_bak] = true }

            it "should append _test to the end of the file, but no .bak" do
                @generator.start.should == "#{@file}_test"
            end
        end
    end

    describe "name generation with the prefix method" do
        before(:each) { @generator[:prefix] = "test" }

        describe "default behavior" do
            it "should prepend test_ to the start of the file with the _with_prefix method" do
                @generator.send(:_with_prefix, @file, "test").should == "test_#{@file}"
            end

            it "should append test_ to the start of the filename and .bak to the end" do
                @generator.start.should == "test_#{@file}.bak"
            end
        end

        describe "with the no_bak option as well" do
            before(:each) { @generator[:no_bak] = true }

            it "should append test_ to the start of the filename and no .bak at the end" do
                @generator.start.should == "test_#{@file}"
            end
        end
    end

    describe "name generation with the target_path method" do
		before(:each) do
			@target = "test"
			@generator[:target_path] = @target
			`mkdir test`
		end

		after(:each) do
			`rm -rf test`
		end

		describe "default behavior" do
			it "should place the file in the target path directory" do
				@generator.send(:_with_target_path, @file, @target).should == "#{@target}/#{@file}"
			end
		end
	end

    describe "name generation with the replace method" do
        before(:each) do
            @before = 0
            @after = 1
            @names_text = [@file, "productionfile.txt"]
            @names_reg = ["file.2008-11-22", "file.2013-33-44"]
            @replace_text = { pattern: Regexp.new("test"), replace: "production" }
            @replace_reg1 = { pattern: Regexp.new('[0-9]{4}-[0-9]{2}-[0-9]{2}'), replace: "2013-33-44" }
            @replace_reg2 = { pattern: Regexp.new('\d{4}-\d{2}-\d{2}'), replace: "2013-33-44" }
            @generator = Bak::BackupNameGenerator.new(@file, replace: @replace_text)
        end

        it "should replace the word test with production with the _with_replace method" do
            @generator.send(:_with_replace, @names_text[@before], @replace_text).should == @names_text[@after]
        end

        it "should allow for regular expressions" do
            @generator.send(:_with_replace, @names_reg[@before], @replace_reg1).should == @names_reg[@after]
        end

        it "should be able to handle backslashes" do
            @generator.send(:_with_replace, @names_reg[@before], @replace_reg2).should == @names_reg[@after]
        end

        it "should replace the word test with production in the filename" do
            @generator.start.should == "productionfile.txt.bak"
        end

        describe "with the no_bak options as well via the start method" do
            it "it shouldn't add .bak at the end if the no_bak flag is included" do
                @generator[:no_bak] = true
                @generator.start.should == @names_text[@after]
            end
        end
    end
end
