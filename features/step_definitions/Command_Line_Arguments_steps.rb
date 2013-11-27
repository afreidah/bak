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
    sleep(0.5)
    File.file?("#{@filename}.#{date}.bak").should == true
    `rm #{@filename}*`
 end

When /^I run bak with the postfix option and text "(.*?)"$/ do |post_text|
    @stdin, @stdout, @stderr, @wait_th = Open3.popen3("bin/bak -p #{post_text} #{@filename}")
end

Then /^there should be a copy of the file with "(.*?)" on the end$/ do |postfix|
    sleep(0.5)
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
    sleep(0.5)
    File.exists?("#{prefix}#{@filename}.bak").should == true
    `rm *#{@filename}*`
end
