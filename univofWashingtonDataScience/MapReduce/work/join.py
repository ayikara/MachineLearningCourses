import MapReduce
import sys
import string

"""
Word Count Example in the Simple Python MapReduce Framework
"""

mr = MapReduce.MapReduce()

# =============================
# Do not modify above this line

def mapper(record):
    # key: document identifier
    # value: document contents
    #exclude = set(string.punctuation)
    key = record[1]
	#lpos = len(record)
    #value = record[1:lpos]
    #value = ''.join(ch for ch in value if ch not in exclude)
    #value = value.lower()
    #words = value.split()
	
    #for w in words:
    mr.emit_intermediate(key, record)

def reducer(key, list_of_values):
    # key: word
    # value: list of occurrence counts
    orderV = []
    orderL = []
    orderJ =[]
    for v in list_of_values:
        if v[0] =='order':
            orderV = v #[1:len(v)]
            break
    orderJ = orderV
    for v in list_of_values:
        if v[0] =='line_item':
            orderL = v #[1:len(v)]
            #orderV.extend(orderL)
            #mr.emit((key, len(orderV+orderL)))
            mr.emit((orderV+orderL))
            #orderV = orderJ
            #mr.emit((key, orderL))

    #orderV = []
    #orderL = []
    #for v in list_of_values:
      #if v[0] =='order':
        #orderV = v[1:len(v)]
    #orderJ =[]
	
    #for v in list_of_values:
        #if v[0] =='line_item':
            #orderJ =
            #orderL = v[1:len(v)]
			#orderJ = orderV.append(orderL)
            #mr.emit((key, orderV.append(orderL)))
 
 

# Do not modify below this line
# =============================
if __name__ == '__main__':
  inputdata = open(sys.argv[1])
  mr.execute(inputdata, mapper, reducer)
