#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys
import re

args = sys.argv
billing_file = args[1]

p = re.compile('\d{12}')

fr = open(billing_file, 'rb')
for line in fr:
    s = line.split(',')
    linked_account_id = s[2].replace('"', '')
    if p.match(linked_account_id):
        output_file = linked_account_id + "_" + billing_file
        fw = open(output_file, 'a')
        fw.write(line)
        fw.close()
