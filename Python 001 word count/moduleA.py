# -*- coding: utf-8 -*-
"""
Created on Thu Oct 26 11:12:41 2017

@author: Russell Xing
"""

## Open and read the file
def get_text(file_name):  
    file = open(file_name)
    contents = file.readlines()
    file.close()
    return contents


def process_data(text_data):
    letters = []
    alphabetic = ('q','w','e','r','t','y','u','i','o','p','a','s','d','f','g','h','j','k','l','z','x','c','v','b','n','m')
## Split the file line by line, than letter by letter
    line_text = list(text_data)
    for i in range(len(line_text)):
        line_text[i] = line_text[i].lower()
        for j in range(len(line_text[i])):
            if line_text[i][j] in alphabetic:
                letters.append(line_text[i][j]) 
    alphabetic = sorted(alphabetic)
    dictionary = {}
## Count the letter
    for element in alphabetic:
        dictionary[element] = letters.count(element)
    return dictionary


def print_output(data_dictionary):
    alphabetic = ('q','w','e','r','t','y','u','i','o','p','a','s','d','f','g','h','j','k','l','z','x','c','v','b','n','m')
    alphabetic = sorted(alphabetic)
## Output result in the format
    for each in alphabetic:
        print(each, format(data_dictionary[each], '>10'), sep = '')
