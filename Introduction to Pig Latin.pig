------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Introduction to Pig Latin
------------------------------------------------------------------------------------------------------------------------------------------------------------------
1. Preliminary Matters
	Pig is data flow language, each processing step result in new dataset or relation
	input = load 'data';	=>	input is a relation 
	
2. It is possible to reuse relation names as below
	A = load 'NYSE_dividends' (exchange, symbol, data, dividends);
	A = filter A by dividends > 0;
	A = foreach A generate UPPER(symbol);
	
	Pig will be able to handle the above data flow, but it is nit recommended to use this way, as we will be losing the track of old relations.
	A					=>	relation or bag
	dividends, symbol 	=>	fields
3. Case-sensitivity
	Keywords are not case-sensitive		=>	load is equivalent to LOAD
	Relation/Fields are case-sensitive	=>	a <> A
	UDF's are also case-sensitive		=>	COUNT <> count
4. Comments
	--		=>	Single Line comments 
	/* */ 	=> 	Multi Line comments
-------------------------------------------------------------------------------------------------------------------------------------------------------------------	
-- Input and Output
-------------------------------------------------------------------------------------------------------------------------------------------------------------------	
1. LOAD
	Pig by default looks for the Tab-delimited files using PigStorage in HDFS.
	Pig by default looks for the file in the home directory => /user/<username> in HDFS
	We can also change the pointer to the different directory while using the LOAD.
	
	divs = LOAD '/data/examples/NYSE_dividends';	=> looking for a file 'NYSE_dividends' under the '/data/examples' directory in HDFS
	
	IN general the file will not be tab-delimited always. You can also load data from the Storage systems other than HDFS.
	
	divs = LOAD 'NYSE_dividends' using HBaseStorage();	=> Loading data from the HBase
	
	If you do not specify the Loader function, then the default storage loader function PigStorage will be used.
	We can also override the default behavior by passing parameters to set which separator to be used.
	
	divs = LOAD 'NYSE_dividends' using PigStorage(',');	=>	Loading comma separated files
	
	Load statement can have a 'AS' clause allowing us specify the field names.
	divs = LOAD 'NYSE_dividends' (exchange, symbol, data, dividends);
-------------------------------------------------------------------------------------------------------------------------------------------------------------------	
2. STORE
	After processing the data, use STORE to write the data.
	By default, Pig writes the data into HDFS in tab-delimited using PigStorage.
	
	STORE processed INTO '/data/examples/processed';	=>	writes the results into the processed directory
	
	We can also store the data in the format other than HDFS
	
	STORE processed INTO 'processed' USING HBaseStorage();
	
	We can also create a Comma Separated file as below
	
	STORE processed INTO 'processed' USING PigStorage(',');
	Note that 'processed' will be directory and the results will be as one or more part files
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
3. DUMP
	While processing data in pIg, we might see how the data looks like in that particular stage. In such situations, DUMP will be useful.
	DUMP just prints the data on the screen. This is useful for debugging.
	
	DUMP processed;	=> Prints the output of the relation in screen. Less optimal.
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Relational Operations	=>	Used for transforming by sorting, joining, projecting and filtering.
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
1. FOREACH
	Takes a set of expressions and applies it for each record of a relation
	
	A = LOAD 'input' AS ( user:chararray, id:long, address;chararray, phone:chararray, preferences:map[]);	=> Loads all the columns into the relation A
	B = FOREACH A GENERATE user, id;																		=> Loads only the user, id
	C = FOREACH A GENERATE $0, $1;																			=> Loads only user,id using Positional Notation
	
	When you have many fiels, you can simply specify .. which refers to the range of fields.
	D = FOREACH A GENERATE ..phone;		=>	Loads user, id, address, phone
	E = FOREACH A GENERATE id..phone;	=>	Loads id, address, phone
	F = FOREACH A GENERATE phone..;		=>	Loads phone, preferences

	bicond	=> 1==1?'Ok':'Not Ok'	=> returns 'Ok'
			=> 2==1?'Ok':'Not Ok'	=> returns 'Not Ok'
			=> null==1?'Ok':'Not Ok'=> returns null
			=> 2==2?'Ok':1			=> error, both the return should be of same type
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
2. FILTER
	Allows you to specify which data you were interested to retain
	
	divs = LOAD 'NYSE_dividends' AS ( exchange:chararray, symbol:chararray, date:chararray, dividends:float);
	cme_ctb_cht    = FILTER divs by symbol IN ('CME','CTB','CHT');
	starts_with_cm = FILTER divs by symbol matches 'CM.*';
	contains_fred  = FILTER divs by symbol matches '.*fred.*';
	one_to_five    = FILTER divs by dividends >= 1.0 OR dividends <= 5.0;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
3. GROUP
	Collects together records with the same keys. This is different from the GROUP in SQL.
	In SQL group is associated directly with aggregates functions. In pig the GROUP is not directly connected to aggregate functions.
	
	GROUP just collects all the records with the same keys.
	Grouping can be done on multiple keys. It just creates an another bag with two fields.
		group => group keys
		field => entire bag	
	
	daily = LOAD 'NYSE_daily' as ( exchange, stock, date, dividends);
	grpd  = GROUP daily by ( exchange, stock );
	avg   = FORACH grpd GENERATE GROUP , AVG(daily.dividends);
	DESCRIBE grpd;	=> grpd : { group: (exchange: bytearray, stock: bytearray), daily: {exchange:bytearray, stock:bytearray, date:bytearray, dividends:bytearray}}

	