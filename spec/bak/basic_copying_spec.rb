require 'spec_helper'

describe "backup name generator" do
    let(:file) { "testfile.txt" }
    let(:options) { {:force => false, :no_bak => false} }
    let(:generator) { BackupNameGenerator.new(file, options) }

    it "should append .bak in basic mode" do
        generator.start.should == "#{file}.bak"
    end
end

describe "bakFile" do
    let(:file) { "testfile.txt" }
    let(:bakfile) { BakFile.new(file) }

    describe "existence of file" do
        it "doesn't exist" do
            FileUtils.rm(file) if File.file?(file)
            bakfile.exist?.should == false
        end

        it "does exist" do
            FileUtils.touch(file)
            bakfile.exist?.should == true
            FileUtils.rm(file)
        end
    end
end

describe "copier" do
    let(:file) { "testfile.txt" }
    let(:options) { {:force => false, :no_bak => false} }
    let(:generator) { BackupNameGenerator.new(file, options) }
    let(:copier) { FileCopier.new(file, generator) }

    it { copier.should respond_to :start }
    it { copier.should respond_to :check_errors }

    it "should have a start file" do
        copier.start_file.should == file
    end

    it "should return an error if the start_file doesn't exist" do
        FileUtils.rm(file) if File.file?(file)
        copier.check_errors.should include("No such file or directory")
    end

    it "it should return an error if the end_file already exists" do
        FileUtils.touch(file)
        FileUtils.touch("#{file}.bak")
        copier.check_errors.should include("File already exists")
        FileUtils.rm(file) if File.file?(file)
        FileUtils.rm("#{file}.bak") if File.file?("#{file}.bak")
    end
end


