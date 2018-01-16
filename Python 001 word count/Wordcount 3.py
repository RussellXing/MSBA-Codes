# -*- coding: utf-8 -*-
"""
Created on Thu Oct 26 20:51:04 2017

@author: Russell Xing
"""

import os
import moduleC

script1 = os.path.join(os.getcwd(),'script01.txt')
script2 = os.path.join(os.getcwd(),'script02.txt')

contents1 = moduleC.get_text(script1)
contents2 = moduleC.get_text(script2)

words1 = moduleC.process_data(contents1)
words2 = moduleC.process_data(contents2)
words1_1 = {}

sorted_words1 = sorted(words1, key=lambda x: words1[x], reverse = True)
i = 0
for each in sorted_words1:
    words1_1[each] = words1[each]
    i = i + 1
    if i == 10:
        break
   
#match top10 word occurrance of script1 in script2
words2_1 = words1_1.copy()
for each in words2_1.keys():
    if each in words2:
        words2_1[each] = words2[each]
    else: words2_1[each] = 0
    
words = list(zip(words1_1.keys(),words1_1.values(),words2_1.values()))

moduleC.print_output(words)
#print(words)