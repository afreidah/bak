require 'pry'

Given /^I have the file "(.*?)"$/ do |filename|
    @filename = filename
    FileUtils.touch(@filename)
end

When /^I run bak with the date option$/ do 
    @stdin, @stdout, @stderr, @wait_th = Open3.popen3("bin/bak -d #{@filename}") 
end

Then /^there should be a copy of the file with todays date and \.bak$/ do
    date = Time.new.strftime("%Y-%m-%d")
    sleep(1)
    File.file?("#{@filename}.#{date}.bak").should == true
    `rm #{@filename}*`
 end

When /^I run bak with the postfix option and text "(.*?)"$/ do |post_text|
    @stdin, @stdout, @stderr, @wait_th = Open3.popen3("bin/bak -p #{post_text} #{@filename}")
end

Then /^there should be a copy of the file with "(.*?)" on the end$/ do |postfix|
    sleep(1)
    File.exists?("#{@filename}#{postfix}").should be_true
    `rm #{@filename}*`
end

When /^I run bak with the postfix option and the text "(.*?)" and the no_bak option$/ do |post_text|
    @stdin, @stdout, @stderr, @wait_th = Open3.popen3("bin/bak -n -p #{post_text} #{@filename}")
end

When /^I run bak with the force option then$/ do
    @pre_status = `ls -l #{@filename}.bak`
    @stdin, @stdout, @stderr, @wait_th = Open3.popen3("bin/bak -f #{@filename}")
end

Then /^it should overwrite the existing file$/ do
    @post_status = `ls -l testfile2.txt.bak`
    (@pre_status == @post_status).should == false
    `rm testfile2.txt*`
end

When /^I run bak with the prefix option and the text "(.*?)"$/ do |pre_text|
    @stdin, @stdout, @stderr, @wait_th = Open3.popen3("bin/bak -s #{pre_text} #{@filename}")
end

Then /^there should be a copy of the file with "(.*?)" on the start$/ do |prefix|
    sleep(1)
    File.exists?("#{prefix}#{@filename}.bak").should == true
    `rm *#{@filename}*`
end

Given /^I want to replace "(.*?)" with "(.*?)"$/ do |pattern, replacement_pattern|
    @pattern = pattern
    @replacement = replacement_pattern
end

When /^I run bak with the replacement option$/ do
    @stdin, @stdout, @stderr, @wait_th = Open3.popen3("bin/bak -R #{@pattern} -R #{@replacement} #{@filename}")
end

Then /^there should be a file called "(.*?)"$/ do |newfile|
    sleep(5)
    File.exist?(newfile).should == true
    `rm #{newfile}`
    `rm #{@filename}*`
end

Given /^I have a folder in the working directory called "(.*?)"$/ do |folder_name|
    @folder_name = folder_name
    `mkdir #{folder_name}`
end

When /^I run bak with the target\-path option$/ do
    @stdin, @stdout, @stderr, @wait_th = Open3.popen3("bin/bak -t #{@folder_name} #{@filename}")
end

Then /^it should create the file "(.*?)"$/ do |filename|
    sleep(5)
    File.exist?(filename).should == true
    `rm #{@filename}`
    `rm -rf #{@folder_name}`
end

Given /^I do not have a folder in the working directory called "(.*?)"$/ do |target_path|
	@folder_name = target_path
	Dir.rmdir(@folder_name) if Dir.exist?(@folder_name)
end

Then /^it should generate a target path doesn't exist error$/ do
  @output = @stderr.read()
  @output.should include("#{@folder_name} directory does not exist")
  `rm #{@filename}`
  `rm -rf #{@folder_name}`
end

When /^I run bak with the target\-path option and the create option$/ do
	@stdin, @stdout, @stderr, @wait_th = Open3.popen3("bin/bak -ct #{@folder_name} #{@filename}")
end

When /^I run bak with the create option and no target_path option$/ do
	 @stdin, @stdout, @stderr, @wait_th = Open3.popen3("bin/bak -c #{@filename}")
end

Then /^it should generate a no target path provided error$/ do
	@output = @stderr.read()
	@output.should include("please specify target directory to create with the -t option")
  `rm #{@filename}`
  `rm -rf #{@folder_name}`
end
