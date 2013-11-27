Feature: Basic Backup

    when run with no arguments against a filename it should create
    a backup by simply appending '.bak' to the filename.

    Scenario: a simple backup
        Given I have a file 'testfile.txt'
        When I run 'bak testfile.txt'
        Then there should be a file 'testfile.txt.bak'

    Scenario: the file does not exist
        Given 'testfile.txt' does not exist
        When I run 'bak testfile.txt'
        Then I should get a "No such file or directory" error

    Scenario: the target file already exists
        Given I have a file 'testfile.txt'
        And I have a file 'testfile.txt.bak'
        When I run 'bak testfile.txt'
        Then I should get a "File already exists" error
