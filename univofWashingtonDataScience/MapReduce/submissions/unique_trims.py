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
    # key: length of the sequence. this helps in sorting and eliminating duplicates.
    # value: document contents
    #key = record[0]	
    value = record[1]	
    value = value.replace(' ', '')[:-10].upper()  
    key = len(value)	
    mr.emit_intermediate(key, value)
   

def reducer(key, list_of_values):
    # key: length of sequence
    # value: list of dna trims
    
    unique_values = list(set(list_of_values)) 
    for val in unique_values:
        mr.emit(val)
 
 

# Do not modify below this line
# =============================
if __name__ == '__main__':
  inputdata = open(sys.argv[1])
  mr.execute(inputdata, mapper, reducer)
