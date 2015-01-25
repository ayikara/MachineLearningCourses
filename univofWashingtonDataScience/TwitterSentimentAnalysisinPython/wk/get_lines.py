#!/usr/bin/python

# import modules used here -- sys is a very standard one
import sys

# Gather our code in a main() function
def main():
    #print 'Hello there', sys.argv[1]
    # Command line args are in sys.argv[1], sys.argv[2] ...
    # sys.argv[0] is the script name itself and can be ignored
	#fin = open('output.txt', 'r')    
    N=19
    n=0
    fout= open('sample.txt','w')
    myfile = open('output.txt','r')
    #with open('output.txt','r') as myfile:
        #head = myfile.readlines(N)
    for line in myfile:
        #read_data =myfile.readline()
        fout.write(line)
        n=n+1
        if n > N:
            break
    fout.close()
    myfile.close()
# Standard boilerplate to call the main() function to begin
# the program.
if __name__ == '__main__':
    main()
