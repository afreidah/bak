require 'spec_helper'

describe "name generation with the date method" do
    let(:file) { "testfile.txt" }
    let(:generator) { BackupNameGenerator.new(file, :date => true) }
    let(:date) { todays_date = Time.new.strftime("%Y-%m-%d") }

    it "should append the date with the _with_date method" do
        generator.send(:_with_date, file).should == "#{file}.#{date}"
    end

    it "should append today's date and .bak to the file" do
        generator.start.should == "#{file}.#{date}.bak"
    end
end

describe "name generation with the postfix method" do
    describe "default behavior" do
        let(:file) { "testfile.txt" }
        let(:generator) { BackupNameGenerator.new(file, :postfix => "test") }

        it "should append _test with the _with_postfix method" do
            generator.send(:_with_postfix, file, "test").should == "#{file}_test"
        end

        it "should append _test.bak to the end of the file" do
            generator.start.should == "#{file}_test.bak"
        end
    end

    describe "with the no_bak option as well" do
        let(:file) { "testfile.txt" }
        let(:generator) { BackupNameGenerator.new(file, :postfix => "test", :no_bak => true) }

        it "should append _test to the end of the file, but no .bak" do
            generator.start.should == "#{file}_test"
        end
    end
end

describe "name generation with the prefix method" do
    describe "default behavior" do
        let(:file) { "testfile.txt" }
        let(:generator) { BackupNameGenerator.new(file, :prefix => "test") }

        it "should prepend test_ to the start of the file with the _with_prefix method" do
            generator.send(:_with_prefix, file, "test").should == "test_#{file}"
        end

        it "should append test_ to the start of the filename and .bak to the end" do
            generator.start.should == "test_#{file}.bak"
        end
    end

    describe "with the no_bak option as well" do
        let(:file) { "testfile.txt" }
        let(:generator) { BackupNameGenerator.new(file, :prefix => "test", :no_bak => true) }

        it "should append test_ to the start of the filename and no .bak at the end" do
            generator.start.should == "test_#{file}"
        end
    end
end

describe "name generation with the replace method" do
    let(:file) { "testfile.txt" }
    let(:generator) { BackupNameGenerator.new(file, :replace => {:pattern => "test", :replace => "production"}) }

    it "should replace the word test with production with the _with_replace method" do
        generator.send(:_with_replace, file, :pattern => "test", :replace => "production").should == "productionfile.txt"
    end

    it "should replace the word test with production in the filename" do
        generator.start.should == "productionfile.txt.bak"
    end

    describe "with the no_bak options as well" do
        let(:file) { "testfile.txt" }
        let(:generator) { BackupNameGenerator.new(file, :no_bak => true, :replace => {:pattern => "test", :replace => "production"}) }

        it "it shouldn't add .bak at the end if the no_bak flag is included" do
            generator.start.should == "productionfile.txt"
        end
    end
end
