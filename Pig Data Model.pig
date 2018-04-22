------------------------------------------------------------------------------------------------------------------------------------------------------------------
Pig Data Model
------------------------------------------------------------------------------------------------------------------------------------------------------------------
Pig Data types 
	1. Scalar Types 	=>	Contains a single value
		------------------------------------------------------------------------------------------------------------------------
		|	Types		|	Java Interface		|	Comments			|	Example		|
		-------------------------------------------------------------------------------------------------------------------------
		|	Int		|	java.lang.Integer	|	4 byte signed integers		|  	42		|
		|	Long            |	java.lang.Long		|	8 byte signed integers		|	5000000000L	|
		-------------------------------------------------------------------------------------------------------------------------
		|	Biginteger  	|	java.math.BigInteger	|	Since pig 0.12 => infinite size	|			|
		|			|				|	worst in performance		|			|
		------------------------------------------------------------------------------------------------------------------------
		|	Float		|	java.lang.Float		|   4 byte floating point		|	3.14f		|
		|	Double		|	java.lang.Double	|	8 byte double			|	7.889		|
		------------------------------------------------------------------------------------------------------------------------
		|	Bigdecimal	|	java.math.BigDecimal	|For calculations where we need no 	|			|
		|			|				|precision loss, use bigdecimal.	|			|
		|			|				|infinite size => slower than float	|			|
		|			|				|Be aware that when 1/3 may lead to	|			|
		|			|				|out of memory error. So you might 	|			|
		|			|				|need to cast to bigdecimal		|			|
		------------------------------------------------------------------------------------------------------------------------
		|	Chararray	|	java.lang.String	|					|	'fred'		|
		|	Boolean		|	java.lang.Boolean	|	not case sensitive		|	true, false	|
		|	datetime	|	org.joda.time.DateTime	|					|			|
		|	bytearray	|	DataByteArray		|					|			|
		-------------------------------------------------------------------------------------------------------------------------		
	2. Complex Types	=>	Contains other types
		a.maps			=>  chararray-to-data element mapping ( key, value )
			typed		=>  Value must be of declared data type
			untyped		=>	Pig does not expect a datatype for the value, it will assign as bytearray by default
					    K1      V1	  K2	V2				
			Example		=> ['name'#'bob','age'#55]
		b.tuples
			Fixed length, ordered collection of data
			Element in a tuple can be of any type and all elements need not to be of same types
			Tuples are further divided into fields
			Tuple is analogous to a row in table
						  f1, f2
			Example		=>	('bob', 55)
		c.bags
			Un-ordered collection of tuples
						  tuple1      tuple2	  tuple3
			Example		=>	{('sally',25)('bob,55'),('john',20)}
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Pig Casting
------------------------------------------------------------------------------------------------------------------------------------------------------------------
1. Loading data without giving schema
	dividends	= LOAD 'NYSE_dividends' AS (exchange, symbol, date, dividend);
	If no schema is defined, then Pig will automatically consider each field as bytearray in runtime.

2. Loading data with schema
	dividends	= LOAD 'NYSE_dividends' AS (exchange:chararray, symbol:chararray, date:chararray, dividend:float);
	
3. Runtime declaration of schemas will be good, but it will be difficult if we have more columns in our data. 
	You can even use the schema using the LOAD function as below.
	mdata = LOAD 'mydata' using HCatLoader();
	
4. daily = load 'NYSE_daily';
   calcs = FOREACH daily generate $7/1000, $3 * 100.0, SUBSTRING($0, 0, 1), $6 - $3;
   
   $3, $6, $7 	=> 	positional notation of the fields => positional notation starts from 0,1,..and so on
   $7/1000		=>	1000 is an integer => pig understands that $7 could be something which can be casted as integer
   $3 * 100.0	=>	100.0 is a double  => pig understands that $3 could be as double
  
   There are cases where Pig cannot identify the resultant data type should be.
   $6 > $3		=>	> operator is valid on numberic, chararray, bytearray. In these cases, pig will consider as bytearray.

Casting	=> same as in java
=======
	player = load 'baseball as ( name: chararray, team: chararray, pos:bag{t:(p:chararray)},bat:map[]);
	unintended = foreach player generate (int)bat#'base_on_balls' - (int)bat#'ibbs';
	
	By default map of 'base_on_balls' and 'ibbs' will be represented as bytearray. Using cast we were converting bytearray to int.
