import string
import collections

def main():
    s = "string. With. Punctuation?" # Sample string 
    exclude = set(string.punctuation)
    s = ''.join(ch for ch in s if ch not in exclude)
    #print s
    #s = s.upper()
    s = s.lower()
    #print s
    lr =[]
    lr.append('a')
    lr.append('z')
    #print lr
    x = [1,2,3,4] 
    #if 42 in x:
       #print 'Y'
    #else:
		#print 'N'
    #y = len(x)
    #val =x[1:y]
    #print val
    lk = ["a", "b", "mpilgrim", "z", "example"]
    li = lk
    lj = ["a2", "b2", "mpilgrim2", "z2", "example2"]
    li.extend(lj)
    #print li #.extend(["a2", "b2", "mpilgrim2", "z2", "example2"])
    #print lk
	#unique values by remove repeating terms- single values of duplicates will be present
    t = [1, 2, 3, 1, 2, 5, 6, 8, 7]
    k= list(set(t))
    print k
    #t = [['1', '2'],  ['2', '1'], ['5', '6'], ['7', '8']]
    #k= list(set(t))
	#set(t[0]) & set(t[1])
	#list(set(t[0]) & set(t[1]))
    #if(set(t[0]) == set(t[1])):
        #print 'eq'
    #if(t[0] == t[1]):
        #print 'eq2'
    #else:
        #print 'nq'
    #print k
    #print t
	#identify duplicates and remove all duplicate terms altogether
    #a = [1,2,3,2,1,5,6,5,5,5]
    #z=[x for x, y in collections.Counter(a).items() if y > 1]
    #print z
    #y =list(set(a) - set(z))
    #print y
        

if __name__ == '__main__':
    main()