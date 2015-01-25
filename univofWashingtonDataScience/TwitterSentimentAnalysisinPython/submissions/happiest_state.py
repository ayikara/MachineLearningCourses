import sys
import json

sentimentData = sys.argv[1] #AFIN-111.txt
twitterData = sys.argv[2] #output.txt

def hw(score_dict,tweets):
#Iterate through the list and capture location if place is present
    state_dict = dict()
    for index in range(len(tweets)):
        if all(k in tweets[index].keys() for k in ("text","place")):
            if not (tweets[index]["place"] == None):                
                tweet_word = tweets[index]["text"].split()
                tweet_state = tweets[index]["place"]["country_code"]
                sent_score = 0
                for word in tweet_word:

	                if word.encode('utf-8') in score_dict.keys():
		                sent_score = sent_score + float(score_dict[word])
	                else:
		                sent_score = sent_score

                if tweet_state.encode('utf-8') in state_dict.keys():
	                state_dict[tweet_state].append(sent_score)
                else:
	                state_dict[tweet_state] = []
	                state_dict[tweet_state].append(sent_score)

    state_list = []                        
    max_score = 0
    happiest_state = ""
    for state in state_dict.keys():
        state_score = 0
        state_list = state_dict[state]
   
        for score in state_list :
            state_score = state_score + float(score)
        
        state_score = state_score/len(state)
                              
        if happiest_state == "" or state_score > max_score:
            max_score = state_score
            happiest_state = state
        
    
    print happiest_state

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
