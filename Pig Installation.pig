----------------------------------------------------------------------------------------------------------------------------------------------
-- How to install and run Pig
----------------------------------------------------------------------------------------------------------------------------------------------
Good to know :
1. Pig does not need to be installed on hadoop cluster
2. It can be installed on a machine which has access to launch hadoop jobs
   In real production environment, administrators will set up GATEWAY nodes which are not part of the actual clusters.But they have access to Hadoop cluster. 
   This will help administrators to install and update Pig and associated tools easily and also to provide secure access to cluster.
3. Pig will be installed on Gateway nodes normally.
4. If the hadoop is accessible from your local machine/laptop, you can install in your local machine.
5. Pig core is developed in JAVA, so it is portable to any OS versions.
6. Pig 0.15 and later releases requires Java 1.7. Older versions before Pig 0.15 requires Java 1.6
7. Pig supports both hadoop versions - hadoop 1 and hadoop 2. But if you use Pig version 0.10, 0.11 or 0.12 with hadoop 2 you might need to recompile Pig with the below code.
   ant -Dhadoopversion=23 jar-withouthadoop
8. Pig support to hadoop 1 will be dropped from pig version 0.17

Installation :
1. Download Pig binary from the Apache website
2. unzip the file 
3. Add the environment variables
			export PATH=$PATH:/<pig bin path>
			export PIG_HOME=<actual pig binary files location>
			export PIG_CLASSPATH=$HADOOP_HOME/conf
4. enter "pig -version" in the command to test the pig installation