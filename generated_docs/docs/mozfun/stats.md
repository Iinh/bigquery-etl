# stats

Statistics functions.


## mode_last_retain_nulls (UDF)

Returns the most frequently occuring element in an array. In the case
of multiple values tied for the highest count, it returns the
value that appears latest in the array. Nulls are retained.
See also: `stats.mode_last, which ignores
nulls.


[Source](https://github.com/mozilla/bigquery-etl/blob/master/sql/mozfun/stats/mode_last_retain_nulls)  |  [Edit](https://github.com/mozilla/bigquery-etl/edit/master//sql/mozfun/stats/mode_last_retain_nulls/metadata.yaml)



## mode_last (UDF)

Returns the most frequently occuring element in an array.

In the case of multiple values tied for the highest count, it returns
the value that appears latest in the array. Nulls are ignored.
See also: `stats.mode_last_retain_nulls`,
which retains nulls.


[Source](https://github.com/mozilla/bigquery-etl/blob/master/sql/mozfun/stats/mode_last)  |  [Edit](https://github.com/mozilla/bigquery-etl/edit/master//sql/mozfun/stats/mode_last/metadata.yaml)

