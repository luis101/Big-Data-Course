
from __future__ import division
import csv
from string import punctuation
from nltk.corpus import stopwords
import argparse

parser = argparse.ArgumentParser(description='Parse Lexis-Nexis files.')
parser.add_argument('--file', metavar='file', type=str, nargs='+', help='Lexis-Nexis file.')
parser.add_argument('--out', metavar='output', type=str, nargs='+', help='Lexis-Nexis output file.')
args = vars(parser.parse_args())

if args['file'] is not None:
    file = args['file']
file = file[0]	
	
print file

#directory = ['C:\Users\lukazimm\Documents\Big Data\CompanyNews\'']
#news = open(directory+file").read()

news = open(file).read()
news_list = news.split('\n')

pos_sent = open("positivger.txt").read()
positive_words=pos_sent.split('\n')
positive_counts=[]

neg_sent = open("negativger.txt").read()
negative_words=neg_sent.split('\n')
negative_counts=[]

stop = stopwords.words('german')
	
print stop
print neg_sent
print pos_sent

for news in news_list:
    positive_counter=0
    negative_counter=0
    
    news_adjusted=news.lower()
    
    
    for p in list(punctuation):
        news_adjusted=news_adjusted.replace(p,'')

    words=news_adjusted.split(' ')

    word_count=len(words)

    for word in words:
        if word in positive_words:
            positive_counter=positive_counter+1
        elif word in negative_words: 
            negative_counter=negative_counter+1
        
    positive_counts.append(positive_counter/word_count)
    negative_counts.append(negative_counter/word_count)

if args['out'] is not None:
    out = args['out']
out = out[0]

print out

output=zip(news_list,positive_counts,negative_counts)

writer = csv.writer(open(out, 'wb'))
writer.writerows(output)

