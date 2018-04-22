------------------------------------------------------------------------------------------------------------------------------------------------------------------
Pig Data Model
------------------------------------------------------------------------------------------------------------------------------------------------------------------
Pig Data types 
	1. Scalar Types 	=>	Contains a single value
		------------------------------------------------------------------------------------------------
		|	Types		|	Java Interface		|	Comments							|	Example		|
		-------------------------------------------------------------------------------------------------
		|	Int			|	java.lang.Integer	|	4 byte signed integers				|  	42			|
		|	Long        |	java.lang.Long		|	8 byte signed integers				|	5000000000L	|
		-------------------------------------------------------------------------------------------------
		|	Biginteger  |	java.math.BigInteger|	Since pig 0.12 => infinite size		|				|
		|				|						|	worst in performance				|				|
		-------------------------------------------------------------------------------------------------
		|	Float		|	java.lang.Float		|   4 byte floating point				|	3.14f		|
		|	Double		|	java.lang.Double	|	8 byte double						|	7.889		|
		-------------------------------------------------------------------------------------------------
		|	Bigdecimal	|	java.math.BigDecimal|	For calculations where we need no 	|				|
		|				|						|	precision loss, use bigdecimal.		|				|
		|				|						|	infinite size => slower than float	|				|
		|				|						|	Be aware that when 1/3 may lead to	|				|
		|				|						|	out of memory error. So you might 	|				|
		|				|						|	need to cast to bigdecimal			|				|
		-------------------------------------------------------------------------------------------------	
		|	Chararray	|	java.lang.String	|										|	'fred'		|
		|	Boolean		|	java.lang.Boolean	|	not case sensitive					|	true, false	|
		|	datetime	|org.joda.time.DateTime	|										|				|
		|	bytearray	|	DataByteArray		|										|				|
		-------------------------------------------------------------------------------------------------		
	2. Complex Types	=>	Contains other types
		a.maps			=>  chararray-to-data element mapping ( key, value )
			typed		=>  Value must be of declared data type
			untyped		=>	Pig does not expect a datatype for the value, it will assign as bytearray by default
							K1		V1		K2	V2				
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
								tuple1		tuple2		tuple3
			Example		=>	{('sally',25)('bob,55'),('john',20)}