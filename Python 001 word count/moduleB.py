# -*- coding: utf-8 -*-
"""
Created on Thu Oct 26 16:58:17 2017

@author: Russell Xing
"""


def get_text(file_name):  
    file = open(file_name)
    contents = file.readlines()
    file.close()
    return contents


def process_data(text_data):
    words = []
    dictionary = {}
## Split the file word by word
    text_data = list(text_data)
    for line in text_data:
        seperators = [',','.','!','?','[',']','(',')','-','/','\\',':',';','\n','\'','"','*','`']
        for seperator in seperators:
            line = line.replace(seperator,' ')
        line = line.split()
        for each in line:
            if len(each) > 1:
                words.append(each)
## Count the words
    words2 = list(set(words))
    for each in words2:
        dictionary[each] = words.count(each)
    return dictionary
        

def print_output(data_dictionary):
## Output result in the format
    for key in data_dictionary.keys():
        print(format(key, '<19'), format(data_dictionary[key], '>3'), sep = '')


        