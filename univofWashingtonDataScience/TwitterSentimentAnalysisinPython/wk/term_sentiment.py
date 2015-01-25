import sys
import json

sentimentData = sys.argv[1] #AFIN-111.txt
twitterData = sys.argv[2] #output.txt

def hw(score_dict,tweet_list):
    #print 'Hello, world!'	
    accum_term = dict()
    #Calculating score_dict scores for the whole tweet with unknown terms set to score of zero
    #then accumulate a dictionary of list of values with each new term occurance with the new term as key.
    for index in range(len(tweet_list)):
        if tweet_list[index].has_key("text"):
            tweet_word = tweet_list[index]["text"].split()
            sent_score = 0
            term_count = {}
            term_list = []
            
            for word in tweet_word:
                word = word.rstrip('?:!.,;"!@')
                word = word.replace("\n", "")
  
                if not (word.encode('utf-8', 'ignore') == ""):
                    if word.encode('utf-8') in score_dict.keys():
                        sent_score = sent_score + float(score_dict[word])
			
                    else:
                        sent_score = sent_score
                        accum_term[word] = []
                        term_list.append(word)
                        if word.encode('utf-8') in term_count.keys():
                            term_count[word] = term_count[word] + 1
                        else:
                            term_count[word] = 1

          
            for word in term_list:
                accum_term[word].append(sent_score)
                
                        
                              

    for key in accum_term.keys():
        num_pos = 0
        num_neg = 0
        adjusted_score = 0
        term_value = 0
        total_sum = 0
        for score in accum_term[key]:
            total_sum = total_sum + score
            
                
        term_value = (total_sum)/len(accum_term[key])
        
        adjusted_score = "%.3f" %term_value
        print key.encode('utf-8') + " " + adjusted_score

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
