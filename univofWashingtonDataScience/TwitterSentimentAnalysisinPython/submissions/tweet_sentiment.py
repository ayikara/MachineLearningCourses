import sys
import json

sentimentData = sys.argv[1] #AFIN-111.txt
twitterData = sys.argv[2] #output.txt

def hw(score_dict,tweet_list):
    #print 'Hello, world!'
    idx = 0
    default ='*'
    for tw in tweet_list:
        #print tw
        sent_score = 0
        tw_ = tw.get('text', default)
        if(tw_ <> default):
            tweet_word = tw_.split()
            for word in tweet_word:
                word = word.rstrip('?:!.,;"!@')
                word = word.replace("\n", "")
            
                if not (word.encode('utf-8', 'ignore') == ""):
                    if word.encode('utf-8') in score_dict.keys():
                        sent_score = sent_score + float(score_dict[word])
                    
                    else:
                        sent_score = sent_score 
            
            #print tweet_word
        
            
        #print tw
        idx = idx + 1
        print sent_score
        
    #print idx

def lines(fp):
    print str(len(fp.readlines()))

def getsentimentscores(afinnfile):
    scores = {} # initialize an empty dictionary
    for line in afinnfile:
        term, score  = line.split("\t")  # The file is tab-delimited. "\t" means "tab character"
        scores[term] = int(score)  # Convert the score to an integer.
    return scores

def getfeedscores(tweeterfile):
    tweetsList = [] # initialize an empty list
    for line in tweeterfile:
        
        tweetsList.append(json.loads(line))
        #print feed_data
        #break
    return tweetsList

def main():
    sent_file = open(sentimentData)
    tweet_file = open(twitterData)
    score_dict = getsentimentscores(sent_file)
    tweet_list  = getfeedscores(tweet_file)
    #print score_dict
    hw(score_dict,tweet_list)
    #lines(sent_file)
    #lines(tweet_file)

if __name__ == '__main__':
    main()
