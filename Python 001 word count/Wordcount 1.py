# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

import os
import moduleA

script1 = os.path.join(os.getcwd(),'script01.txt')
script2 = os.path.join(os.getcwd(),'script02.txt')

contents1 = moduleA.get_text(script1)
contents2 = moduleA.get_text(script1)

letters1 = moduleA.process_data(contents1)
letters2 = moduleA.process_data(contents1)

print('\nscript01:\n')
moduleA.print_output(letters1)
print('\nscript02:\n')
moduleA.print_output(letters2)