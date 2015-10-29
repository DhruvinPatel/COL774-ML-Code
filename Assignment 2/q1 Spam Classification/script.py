import sys
import os
import pdb

INPUT_FILE_NAME = 'train'
OUTPUT_FILE_NAME = 'test.txt'
TEST_FILE_NAME = 'test.txt'

in_file = open(INPUT_FILE_NAME,'r')
lines = in_file.readlines()
in_file.close()




dic = {}
#dic2 = {}
l3 = []

def dict_update (l,num):
	l2 = str.split(l)
	#if l2[1] =='ham':
	#	l3.append('1')
	#else:
	#	l3.append('-1')
	i=2
	while i<len(l2):
		dic[l2[i]] = 1;
		#dic2[num,l2[i]]=l2[i+1]
		i=i+2		

dict1 = {}
dict2 = {}
def dict_update2 (l,num):
	l2 = str.split(l)
	if l2[1] =='ham':
		l3.append('1')
	else:
		l3.append('-1')
	i=2
	while i<len(l2):
	#	dict1[l2[i]] = 1;
		dict2[num,l2[i]]=l2[i+1]
		i=i+2	


for i in range(len(lines)):
	dict_update(lines[i],i);

print dic	
print len(dic)

f = open(sys.argv[1],'r')
line2 = f.readlines()
for i in range(len(line2)):
	dict_update2(line2[i],i)
	

f.close()

f = open (sys.argv[2], 'w')

for i in range(len(line2)):
	wd = str.split(line2[i])
	for w in dic:
		if(dict2.has_key((i,w))):
			f.write(dict2[i,w]+' ')
		else:
			f.write('0 ')		
	f.write('\n')
f.close()

f = open (sys.argv[3], 'w')
for i in range(len(line2)):
	f.write(l3[i])
	f.write('\n')
f.close()


print l3
