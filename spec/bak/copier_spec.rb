require 'spec_helper'
require "rspec/expectations"


describe "Copier" do
    before(:each) do
        @file = "testfile.txt"
        @generator = Bak::BackupNameGenerator.new(@file, {})
        @output = double('stdout')
        @copier = Bak::FileCopier.new(@generator, @output)
        FileUtils.touch(@file)
    end

    after(:each) do
        FileUtils.rm("#{@file}.bak") if File.file?("#{@file}.bak")
        FileUtils.rm(@file) if File.file?(@file)
    end

    it { @copier.start_file.should == @file }
    it { @copier.end_file.should == "#{@file}.bak" }
    it { @copier.should respond_to(:start) }

    it "should return nil to indicate that no errors were received from start" do
        @copier.start.should be_nil
    end

    it "should show a message indicating that the base file is missing" do
        FileUtils.rm(@file) if File.file?(@file)
        @output.should_receive(:puts).with("#{@file}: No such file or directory")
        @copier.start
    end

    it "should tell you if the target file already exists and force mode isn't on" do
        FileUtils.touch(@file)
        FileUtils.touch("#{@file}.bak")
        @output.should_receive(:puts).with("#{@copier.end_file}: File already exists")
        @copier.start
    end
end
