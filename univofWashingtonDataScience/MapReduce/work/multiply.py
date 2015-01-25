import MapReduce
import sys
import string
import collections

"""
Multiply 2 matrix size L,M * M,N -->L x N in the Simple Python MapReduce Framework
"""

mr = MapReduce.MapReduce()

# =============================
# Do not modify above this line

def mapper(record):
    # key: length of the sequence. this helps in sorting and eliminating duplicates.
    # value: document contents
    #key = record[0]
    L = 5
    N = 5
	
    matrix = record[0]	
    #if matrix =='a':
        #key = record[1] 
    #else:
        #key = record[2]
    if matrix =='a':
        keyi = record[1]
        for k in range(L):	
            mr.emit_intermediate((keyi,k), record)
    else:
        keyk = record[2]
        for i in range(N):
            mr.emit_intermediate((i,keyk), record)

def reducer(key, list_of_values):
    # key: length of sequence
    # value: list of dna trims
    # mr.emit((key,len(list_of_values)))

    testrbA = [0,0,0,0,0]
    testrbB = [0,0,0,0,0]
    prodElementA =[0,0,0,0,0]
    prodElementB =[0,0,0,0,0]
    for val in list_of_values:
        element = val[3]
        matrix = val[0]
        if matrix =='a':            
            prodElementA[val[2]]=element
            testrbA[val[2]]=element
        else:
            prodElementB[val[1]]=element
            testrbB[val[1]]=element
        
    prodElement = 	[a*b for a,b in zip(prodElementA,prodElementB)]
    mr.emit((key[0],key[1],sum(prodElement)))
    #for i in range(len(testrbA)):
        #mr.emit((key,testrbA[i]))
    #for i in range(len(testrbB)):
        #mr.emit((key,testrbB[i]))



# Do not modify below this line
# =============================
if __name__ == '__main__':
  inputdata = open(sys.argv[1])
  mr.execute(inputdata, mapper, reducer)
