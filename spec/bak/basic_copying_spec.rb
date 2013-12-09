require 'spec_helper'

describe "basic copying" do
    before(:each) do
        @file = "testfile.txt"
        @options = {:force => false, :no_bak => false}
        @generator = BackupNameGenerator.new(@file, @options)
        @copier = FileCopier.new(@generator, double('stderr'))
        FileUtils.touch(@file)
    end

    after(:each) do
        FileUtils.rm(@file) if File.file?(@file)
        FileUtils.rm("#{@file}.bak") if File.file?("#{@file}.bak")
    end

    describe "backup name generator" do
        it "should append .bak in basic mode" do
            @generator.start.should == "#{@file}.bak"
        end
    end

    describe "copier" do
        it { @copier.should respond_to :start }
        it { @copier.should respond_to :check_errors }

        it "should have a start file" do
            @copier.start_file.should == @file
        end

        it "should return an error if the start_file doesn't exist" do
            FileUtils.rm(@file) if File.file?(@file)
            @copier.check_errors.should include("No such file or directory")
        end

        it "it should return an error if the end_file already exists" do
            FileUtils.touch("#{@file}.bak")
            @copier.check_errors.should include("File already exists")
        end
    end
end
