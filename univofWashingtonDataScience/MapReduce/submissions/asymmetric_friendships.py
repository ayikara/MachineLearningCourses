import MapReduce
import sys
import string
import collections

"""
Word Count Example in the Simple Python MapReduce Framework
"""

mr = MapReduce.MapReduce()

# =============================
# Do not modify above this line

def mapper(record):
    # key: document identifier
    # value: document contents
    record.sort()
    key = record[0]	
    value = record[1]	    
    mr.emit_intermediate(key, value)
    #mr.emit_intermediate(value, key)

def reducer(key, list_of_values):
    # key: word
    # value: list of occurrence counts
    z=[x for x, y in collections.Counter(list_of_values).items() if y > 1]
    unique_values =list(set(list_of_values) - set(z))
    #unique_values = list(set(list_of_values))
    for v in unique_values:
        mr.emit((key,v))
        mr.emit((v,key))
 
 

# Do not modify below this line
# =============================
if __name__ == '__main__':
  inputdata = open(sys.argv[1])
  mr.execute(inputdata, mapper, reducer)
