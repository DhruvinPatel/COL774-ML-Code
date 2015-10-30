import sys
import os
import pdb


TRAIN_FILE_NAME = 'train.data'
TEST_FILE_NAME = 'test.data'
VALIDATION_FILE_NAME = 'validation.data'

in_file = open(TRAIN_FILE_NAME,'r')
tlines = in_file.readlines()
in_file.close()

in_file = open(TEST_FILE_NAME,'r')
testlines = in_file.readlines()
in_file.close()

in_file = open(VALIDATION_FILE_NAME,'r')
vslines = in_file.readlines()
in_file.close()



class Tree(object):
    def __init__(self):
        self.left = None
        self.right = None
        self.center = None
        self.data = None

#global root;
root = Tree()       
numcall = 0

def chooseattr (S,available):
	global numcall
	numatt = len(S[0])-1;
	error = len(S);
	best = -1;
	for xj in available:
		S0 = []
		S1 = []
		S2 = []
		for j in range(len(S)):
			if(S[j][xj]=='y'):
				S0.append(S[j])
			elif (S[j][xj]=='n'):
				S1.append(S[j])
			elif (S[j][xj]=='?'):
				S2.append(S[j])
		#print len(S0);
		#print len(S1);
		#print len(S2);
		#print S2;
		#print numcall;
		#print 'hoooohohoho'

		yr=0
		yd=0
		for j in range(len(S0)):
			if (S0[j][0]=='republican'):
				yr = yr+1;
			elif (S0[j][0]=='democrat'):
				yd = yd+1;

		#yr = len( filter (lambda x: x[0]=='republican'  , S0 )     )		
		#yd = len( filter (lambda x: x[0]=='democrat'  , S0 )     )
		Jy = yd if (yr>yd) else yr

		nr=0
		nd=0
		for j in range(len(S1)):
			if (S1[j][0]=='republican'):
				nr = nr+1;
			elif (S1[j][0]=='democrat'):
				nd = nd+1;

		#nr = len( filter (lambda x: x[0]=='republican'  , S1 )     )
		#nd = len( filter (lambda x: x[0]=='democrat'  , S1 )     )
		Jn = nd if (nr>nd) else nr

		#qr = len( filter (lambda x: x[0]=='republican'  , S2 )     )		
		#qd = len( filter (lambda x: x[0]=='democrat'  , S2 )     )
		qr=0
		qd=0
		for j in range(len(S2)):
			if (S2[j][0]=='republican'):
				qr = qr+1;
			elif (S2[j][0]=='democrat'):
				qd = qd+1;

		Jq = qd if (qr>qd) else qr

		newerror = Jy+Jq+Jn;

		if(newerror<error):
			best = xj
		error = newerror;	

	return best


'''global numnodes'''
#global numnodes
numnodes = 0;
#global gacc
gacc = []
#global firsttime;
firsttime = True;

def GrowTree (S,available):
	#global firsttime
	global numnodes
	#global root
	#global gacc

	flag = 0;
	for i in range(len(S)):
		if (S[i][0]=='democrat'):
			flag = 1;
			break
	if ((flag==0)):
	
		leaf = Tree()
		leaf.data = 'republican'
		'''if(firsttime):
													firsttime = False;
													root = leaf'''
		#print 'leafa'
		numnodes = numnodes+1
		return leaf
	
	flag =1
	for i in range(len(S)):
		if(S[i][0]=='republican'):
			flag = 0
			break
	if (flag==1):
		leaf = Tree()
		leaf.data = 'democrat'
		'''if(firsttime):
									firsttime = False;
									root = leaf'''
		numnodes = numnodes + 1
		return leaf

	global numcall
	numcall = numcall + 1
	xj = chooseattr (S,available)
	available.remove(xj)
	available1 = available[:]
	available2 = available[:]
	available3 = available[:]

	S0 = []#y
	S1 = []#n
	S2 = []#?
	for i in range(len(S)):
		if(S[i][xj]=='y'):
			S0.append(S[i])
		elif (S[i][xj]=='n'):
			S1.append(S[i])
		elif (S[i][xj]=='?'):
			S2.append(S[i])

	#numnodes = numnodes + 1;
	#acc = calcacc (numnodes);
	#gacc.append([numnodes,acc]);
			
	node = Tree()
	'''
				if(firsttime):
						firsttime = False;
						root = node
				'''
	
	node.data = xj
	node.left = GrowTree (S1,available1)
	node.center = GrowTree(S2,available2)
	node.right = GrowTree(S0,available3)
	return node





		
	
tS = []
vS = []
testS = []
for i in range(len(tlines)):
	tS.append(str.split(str.strip(tlines[i]),','))

for i in range(len(vslines)):
	vS.append(str.split(str.strip(vslines[i]),','))

#train = GrowTree(tS);
print len(tlines)
print tlines

available = range(1,len(tS[0]));
vvss = GrowTree(tS,available);
print vvss.data
print vvss.left.data
print vvss.right.data
print vvss.center.data
print 'asdasd'

'''dic = {}
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
	dict_update2(l,i)
	

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

f = open ('test-small.txt', 'w')
for i in range(len(lines)):
	f.write(l3[i])
	f.write('\n')
f.close()


print l3
'''
