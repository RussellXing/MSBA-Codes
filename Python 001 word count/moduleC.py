# -*- coding: utf-8 -*-
"""
Created on Thu Oct 26 20:51:05 2017

@author: Russell Xing
"""

import os

def get_text(file_name):  
    file = open(file_name)
    contents = file.readlines()
    file.close()
    return contents


def process_data(text_data):
    words = []
    dictionary = {}
    file_name = os.path.join(os.getcwd(),'stopwords.csv')
    file = open(file_name)
    stopwords = file.readlines()
    file.close()
    for i in range(len(stopwords)):
        stopwords[i] = stopwords[i].replace('\n','')
## Split the file word by word
    text_data = list(text_data)
    for line in text_data:
        seperators = [',','.','!','?','[',']','(',')','-','/','\\',':',';','\n','\'','"','*','`']
        for seperator in seperators:
            line = line.replace(seperator,' ')
        line = line.split()
        for each in line:
            if (len(each) > 1 and each not in stopwords):
                words.append(each)
## Count the words
    words2 = list(set(words))
    for each in words2:
        dictionary[each] = words.count(each)
    return dictionary
        

def print_output(data_dictionary):
    print(format('WORD', '<10'), format('COUNT 1', '>10'), format('COUNT 2', '>10'), sep = '')
    print('---------------------------------')
## Output result in the format
    for line in data_dictionary:
        print(format(line[0], '<10'), format(line[1], '>10'), format(line[2], '>10'), sep = '')