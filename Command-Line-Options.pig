------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Running Pig in Command-Line
------------------------------------------------------------------------------------------------------------------------------------------------------------------
1. pig -e <command>				=>	Executes a single command in Pig
2. pig -version					=>	displays the pig version
3. pig -P or pig -propertyFile 	=>	Specify the properties that pig should  read
4. pig -h properties			=>	Displays the entire list of properties
5. pig -h						=>  Displays the list of command-line options
------------------------------------------------------------------------------------------------------------------------------------------------------------------
Running HDFS commands in Grunt Shell
------------------------------------------------------------------------------------------------------------------------------------------------------------------
1. hadoop fs shell commands are available in pig.
   fs -ls / => 	list the contents of home directory in hadoop
   Other commands include chgrp, chown, put, mkdir, mv, rm, stat, chmod, cp, du
2. kill <applicationid> => to kill the YARN applications
3. exec [ -param param_name = param_value] [-param_file filename] [script file]
	=> executes the script file when we are in the grunt shell. This is mainly used for testing pig scripts
	=> pig does not combine the scripts before the exec command with the rest of the commands
4. run [ -param param_name = param_value] [-param_file filename] [script file]
	=> executes the script file when in the current grunt shell. This is another way for testing pig scripts
	=> Aliases mentioned in the script file will be available in the grunt shell
------------------------------------------------------------------------------------------------------------------------------------------------------------------
Running External commands in Grunt Shell
------------------------------------------------------------------------------------------------------------------------------------------------------------------
1. sh 						=> runs shell command from within the grunt command
2. sql HCatalog	commands	=> you can run the Hive's HCatalog DDL commands like CREATE,  ALTER, DROP table or partitions in Pig
							=> to use this feature we need to set the hcat.bin entry in the conf/pig.properties file
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Return Codes from pig
------------------------------------------------------------------------------------------------------------------------------------------------------------------
Return value 	|	Meaning								|	Comments						|
---------------------------------------------------------------------------------------------
	0			|	Sucess								|									|
	1			|	Retriable failure                   |									|
	2			|	Failure                             |									|
	3			|	Partial failure                     |	Used in multiquery operations	|
	4			|	Illegal arugments passed to pig     |									|
	5			|	IOException thrown                  |	Mostly thrown by UDF			|
	6			|	PigException thrown                 |	Mostly thrown bu Python UDF		|
	7			|	ParseException                      |									|
	8			|	Throwable thrown                    |	Unexpected exception			|
---------------------------------------------------------------------------------------------
