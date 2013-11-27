Before do
    FileUtils.rm('testfile.txt') if File.exist?('testfile.txt')
    FileUtils.rm('testfile.txt.bak') if File.exist?('testfile.txt.bak')
end

After do
    FileUtils.rm('testfile.txt') if File.exist?('testfile.txt')
    FileUtils.rm('testfile.txt.bak') if File.exist?('testfile.txt.bak')
end

Given /^I have a file 'testfile\.txt'$/ do
    FileUtils.touch('testfile.txt')
end

When /^I run 'bak testfile\.txt'$/ do
    @stdin, @stdout, @stderr, @wait_th = Open3.popen3("bin/bak testfile.txt")
end

Then /^there should be a file 'testfile\.txt\.bak'$/ do
    File.file?('testfile.txt.bak')
end

Given /^'testfile\.txt' does not exist$/ do
    FileUtils.rm('testfile.txt') if File.file?('testfile.txt')
end

Given /^I have a file 'testfile\.txt\.bak'$/ do
    FileUtils.touch('testfile.txt.bak')
end

Then /^I should get a "(.*?)" error$/ do |error_msg|
    @output = @stderr.read()
    @output.should include(error_msg)
end
