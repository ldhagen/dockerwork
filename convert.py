#!/bin/env python

import openpyxl as ox, sqlite3 as sl, string

wb = ox.load_workbook(filename='High_Value_Data_Sets.xlsx', use_iterators=True)
ws = wb.get_active_sheet()

conn = sl.connect('TexScript.db')

conn.execute('create table inmates ("SID Number" ,"TDCJ Number" ,"Name" ,"Current Facility" ,"Gender" ,"Race" ,"DOB" ,"Projected Release" ,"Maximum Sentence Date" ,"Parole Eligibility Date" ,"Case Number" ,"County" ,"Offense Code" ,"Offense" ,"Sentence Date" ,"Offense Date" ,"Sentence Years" ,"Last Parole Decision" ,"Next Parole Review Date" ,"Parole Review Status")')

for x in range(2,ws.max_row):
    current_list = []
    for y in string.ascii_uppercase[:20]:
        current_list.append(ws[y + str(x)].value)
    conn.execute('insert into inmates ("SID Number" ,"TDCJ Number" ,"Name" ,"Current Facility" ,"Gender" ,"Race" ,"DOB" ,"Projected Release" ,"Maximum Sentence Date" ,"Parole Eligibility Date" ,"Case Number" ,"County" ,"Offense Code" ,"Offense" ,"Sentence Date" ,"Offense Date" ,"Sentence Years" ,"Last Parole Decision" ,"Next Parole Review Date" ,"Parole Review Status") values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )', current_list)
    conn.commit()
    print x

