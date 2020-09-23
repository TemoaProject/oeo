#!/usr/bin/env python
# coding: utf-8

import pandas as pd
import sqlite3
import numpy as np
import os
import shutil

# Specify old .sqlite file (used to create template) and final template .sqlite file names
outputdB = 'US_National_template.sqlite'
outputdBold = 'US_National_region.sqlite'

#get all commands from old .sql file
fd = open(outputdBold.replace('ite',''), 'r')
sqlFile = fd.read()
fd.close()

# all .sql file commands (split on ';')
sqlCommands = sqlFile.split(';')


#filter CREATE TABLE commands, and insert into commodities command to retain commodities list
create_sqlCommands=[]
for command in sqlCommands:
    if 'CREATE TABLE' in command:
        table_name = command.split('CREATE TABLE ')[1].split(' ')[0]
        table_name = table_name.replace("'",'').replace('"','').replace('`','')
        create_sqlCommands.append(command)
    if 'INSERT INTO "commodities"' in command:
        create_sqlCommands.append(command)

#write to new .sql file
fd = open(outputdB.replace('ite',''), 'w')
sqlFile = fd.write(";\n".join(create_sqlCommands))
fd.close()

#delte new .sqlite file if exists, and compile new .sqlite file
if os.path.isfile(outputdB):
    os.remove(outputdB)
os.system("sqlite3 " + outputdB + " < " + outputdB.replace('ite',''))

