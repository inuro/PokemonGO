#argtest.py 
# https://docs.python.org/ja/3.8/library/argparse.html

import argparse

parser = argparse.ArgumentParser(description='Simulate Pokemon Battle')
parser.add_argument('-i', '--init', type=bool, default=False, help='Initialize simulation table')
parser.add_argument('-s', '--shield', type=int, default=1, choices=range(0, 3), help='how many shield use in simiulation (0-2)')
parser.add_argument('-c', '--cap', default=1500, choices=['1500','2500','5500','all'], help='level cap (1500,2500,5500,all)')
args = parser.parse_args()
print(args)
if args.init == True:
    print('initialize simulation table')
else:
    print('add to existing table')

caps = []
if args.cap == 'all':
    caps = [1500,2500,5500]
else:
    caps = [int(args.cap)]
print (caps)

if args.init == True:
    query = """
    DROP TABLE if exists simulation;
    CREATE TABLE simulation(
        uid text,
        fast text,
        charge text,
        win integer, draw integer, lose integer,
        cap integer,
        shield integer
    );
    """
print(query)
