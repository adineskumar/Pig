test = load '/home/cloudera/Desktop/dinesh/data_src/test' as line;
words = FOREACH test GENERATE FLATTEN(TOKENIZE(line)) as word;
grp_wrds = GROUP words BY word;
wrd_cnt = FOREACH grp_wrds GENERATE group, COUNT(words);
dump wrd_cnt;
