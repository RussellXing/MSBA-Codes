# -*- coding: utf-8 -*-
"""
Created on Thu Oct 26 16:57:58 2017

@author: Russell Xing
"""

import os
import moduleB

script1 = os.path.join(os.getcwd(),'script01.txt')
script2 = os.path.join(os.getcwd(),'script02.txt')

contents1 = moduleB.get_text(script1)
contents2 = moduleB.get_text(script2)

words1 = moduleB.process_data(contents1)
words2 = moduleB.process_data(contents2)

print('\nscript01:\n')
moduleB.print_output(words1)
print('\nscript02:\n')
moduleB.print_output(words1)