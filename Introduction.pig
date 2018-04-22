----------------------------------------------------------------------------------------------------------------------------------------------
-- Pig
----------------------------------------------------------------------------------------------------------------------------------------------
1. What is Pig?
	Pig is an engine for executing data flows in parallel on Apache Hadoop
	Pig is a data flow language, which allows users to describe how the data can be read, processed and stored in parallel
	Pig uses HDFS for Storage and Mapreduce for Processing
	Pig uses a language called Pig-Latin
	Pig describes a DAG - Directed Acyclic Graph
	
2. How Pig is different from SQL?
	SQL lets users to describe what question they want to be answered, but SQL does not actually let users to describe how the data should be processed.
	Pig allows users to describe the way how the data flow should be.
	
	Each SQL query is designed to answer one single question. If the users want to do some several operations, then user need to write another separate query.
	User might also need to store the intermediate result into staging table to process further.
	But Pig is designed for long series of data operations. So no need of storing of intermediate steps as of SQL.
	
	SQL works only with normalized data and mostly with proper schema defined.
	Pig works on rarely normalized data, and with unknown or inconsistent schema. Pig can operate on data as and when it is loaded into HDFS.
	
3. How Pig runs on hadoop?
	Hadoop 1	=> HDFS	+	Mapreduce
	Hadoop 2	=> HDFS +	YARN(Mapreduce/Spark/Tez) 	
	
4. How Pig is different from Mapreduce
	Pig has provides standard operations like JOIN, FILTER, GROUP By, ORDER BY, UNION.
	Mapreduce provides GROUP BY in the sort and shuffle and reduce phase, ORDER BY is provided indirectly by grouping. But JOIN and UNION have to be programmed by users.

	Mapreduce, the amount of data sent to reducers might be skewed. ( Amount of data in one reducers may be 10X times larger than the other reducers )
	So mapreduce may imbalanced and time consuming.
	But handles this situation by rebalancing the load. 
	
5. What is Pig Useful for?
	1. ETL
	2. Research on raw data
	3. Iterative data processing
	
6. Features of Pig.
	Pig can eat anything
	1. Pig can operate on data whether it has metadata or not.
	2. Pig can work on relational, nested or unstructured data
	3. Pig can operate on data beyond files, key/value stores and databases.
	
	Pig live anywhere
	1. Pig is parallel data processing language and it is not only tied to one particular tool
	2. It can work on tools other than hadoop
	
	Pigs are domestic animals.
	1. Pig allows users to integrate user defined functions for doing transformations
	
	Pig fly.
	1. Pig processes data quickly
	
7. Pig modes
	1. Local mode	=> pig -x local
	2. Mapreduce	=> pig -x mapreduce
	3. Spark        => pig - spark
	4. Tez			=> pig - tez
	5. Tez Local	=> pig -x tez_local
	6. Spark Local  => pig -x spark_local
	
	
	
