require 'spec_helper'

describe "name generation with the date method" do
    let(:file) { "testfile.txt" }
    let(:generator) { BackupNameGenerator.new(file, :date => true) }
 
    it "should append today's date and .bak to the file" do
        todays_date = Time.new.strftime("%Y-%m-%d")
        generator.start.should == "#{file}.#{todays_date}.bak"
    end
end

describe "name generation with the postfix method" do
    describe "default behavior" do
        let(:file) { "testfile.txt" }
        let(:generator) { BackupNameGenerator.new(file, :postfix => "test") }

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
