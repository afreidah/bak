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

	describe "target path option support" do
		after(:each) do
			new_file = "#{@generator[:target_path]}/#{@file}.bak"
			FileUtils.rm(new_file) if File.file?(new_file)
			Dir.rmdir @generator[:target_path] if Dir.exist? @generator[:target_path] 
		end

		it "should tell you that the target path doesn't exist when using -t option" do
			@generator[:target_path] = "path_that_doesnt_exist"
			@copier = Bak::FileCopier.new(@generator, @output)
			@output.should_receive(:puts).with("#{@generator[:target_path]} directory does not exist")
			@copier.start
		end

		it "should create the target path if the create option is passed in" do
			@generator[:target_path] = "path_that_doesnt_exist"
			@generator[:create_path] = true
			@copier = Bak::FileCopier.new(@generator, @output)
			@copier.start
			File.exist?("#{@generator[:target_path]}/#{@file}.bak").should == true
		end

		it "should be able to create multi-level directories using the create option" do
			@generator[:target_path] = "test/test2"
			@generator[:create_path] = true
			@copier = Bak::FileCopier.new(@generator, @output)
			@copier.start
			File.exist?("#{@generator[:target_path]}/#{@file}.bak").should == true
		end
	end
end
