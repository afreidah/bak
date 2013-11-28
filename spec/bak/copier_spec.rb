require 'spec_helper'
require "rspec/expectations"

describe "Copier" do
    before(:each) do
        @file = "testfile.txt"
        @generator = BackupNameGenerator.new(@file, {})
        @copier = FileCopier.new(@file, @generator)
        FileUtils.touch(@file)
    end

    before("file doesn't exist") do
        FileUtils.rm(@file)
    end

    after(:each) do
        begin
            FileUtils.rm("#{@file}*")
        rescue Exception => e
        end
    end

    describe "public interface" do
        it { @copier.start_file.should == @file }
        it { @copier.end_file.should == "#{@file}.bak" }
        it { @copier.should respond_to(:start) }
    end

    describe "no errors" do
        it { @copier.start.should be_nil }
    end


    #describe "file doesn't exist" do
    #    it { STDERR.should_receive(:print).with("No such file or directory") }
    #    it { @copier.start }
    #end

    #    #describe "target file already exists and no force setting" do
    #    #    FileUtils.touch(@file)
    #    #    FileUtils.touch("#{@file}.bak")
    #    #    copier = FileCopier.new(@file, @generator)
    #    #    STDERR.should_receive(:print).with("blah blah")
    #    #    copier.start
    #    #end
    #end
end
