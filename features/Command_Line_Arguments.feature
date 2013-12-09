Feature: CommandLine Options to customize performance

    As a user I want to be able to customize the behavior of the program
    by supplying varias command-line arguments

    Scenario: adding the date
        Given I have the file "testfile2.txt"
        When I run bak with the date option
        Then there should be a copy of the file with todays date and .bak

    Scenario: adding a postfix to the file
        Given I have the file "testfile2.txt"
        When I run bak with the postfix option and text "post"
        Then there should be a copy of the file with "_post.bak" on the end

    Scenario: adding a postfix and using the no_bak option
        Given I have the file "testfile2.txt"
        When I run bak with the postfix option and the text "post" and the no_bak option
        Then there should be a copy of the file with "_post" on the end

    Scenario: adding a prefix to the filename
        Given I have the file "testfile2.txt"
        When I run bak with the prefix option and the text "pre"
        Then there should be a copy of the file with "pre_" on the start

    Scenario: overwriting an existing file with the --force/-f option
        Given I have the file "testfile2.txt"
        And I have the file "testfile2.txt.bak"
        When I run bak with the force option then
        Then it should overwrite the existing file

    Scenario Outline: using regular expressions to do replacements on the filenames
        Given I have the file <filename>
        And I want to replace <pattern> with <replacement>
        When I run bak with the replacement option
        Then there should be a file called <newFilename>

        Examples:
            | filename          | pattern               | replacement       | newFilename               |
            | "testfile.txt"    | "test"                | "production"      | "productionfile.txt.bak"  |
            | "file.2008-23-12" | "'\d{4}-\d{2}-\d{2}'" | "2013-11-27"      | "file.2013-11-27.bak"     |

