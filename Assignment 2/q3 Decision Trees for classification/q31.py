import sys
import os
import pdb
import math
from math import log
import copy
#sys.setrecursionlimit(100000)

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
        self.S = None

#global root;
root = Tree()

def predict (r,ex):
	if(r.data == 'democrat'):
		return 'democrat'

	elif (r.data == 'republican'):
		return 'republican'
	else:
		if(ex[r.data]=='y'):
			return predict(r.right,ex)
		elif (ex[r.data]=='n'):
			return predict(r.left,ex)
		else:
			return predict(r.center,ex)
			
			
'''
function [entr] = entropy(Y)
    entr = 0;
    if(size(Y(Y==0),1)~=0)
        p = size(Y(Y==0),1)/size(Y,1);
        entr = entr - p*log2(p);
    end
    if(size(Y(Y==1),1)~=0)
        p = size(Y(Y==1),1)/size(Y,1);
        entr = entr - p*log2(p);
    end
end
'''


			


def errorcalc1 (r,testlies): #for test data
	error = 0
	ttS = []
	for i in range(len(testlies)):
		ttS.append(str.split(str.strip(testlies[i]),','))
	
	for i in range(len(ttS)):
		ex = ttS[i];
		ans = predict(r,ex);
		if(ans==ttS[i][0]):
			error=error
		else:
			#print ans
			#print ttS[i][0]
			error = error + 1	





	return float (error)/(len(testlies));

def entropy (S):
	S0=[]
	S1=[]
	
	for j in range(len(S)):
		if(S[j][0]=='democrat'):
			S0.append(S[j])
		elif (S[j][0]=='republican'):
			S1.append(S[j])
	if(len(S0)==0):
		ent = 0;
	elif(len(S1)==0):
		ent = 0;
	else:

		ent = - ( len(S0)*log(float (len(S0))/(len(S)))+len(S1)*log( float (len(S1))/(len(S))) )/len(S);
	return ent



def chooseattr2 (S,available):
	numatt = len(S[0])-1;
	gain = 0;
	best = -1;
	entropyS = entropy(S);
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

		
		newgain = entropyS- (len(S0)*entropy(S0)+len(S1)*entropy(S1)+len(S2)*entropy(S2))/len(S);

		if(newgain>gain):
			best = xj
		gain = newgain;	

	return best	



def chooseattr (S,available):
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
prunenode = 0;
#global gacc
#global firsttime;
firsttime = True;

def prune (node):
	if(node.data=='democrat'):
		return
	elif(node.data=='republican'):
		return
	yr =0
	yd = 0	
	for i in range(len(node.S)):
		if(node.S[i][0]=='democrat'):
			yd= yd+1
		elif(node.S[i][0]=='republican'):
			yr= yr+1

	if(yr>yd):
		node.data = 'republican'
	else:
		node.data = 'democrat'
	return

	

def pruning (r,vs,error):
	global pacc
	global prunenode
	global root
	if (r.data=='democrat'):
		#pacc.append([errorcalc1(root,vs),prunenode])
		return
	elif(r.data=='republican'):
		#pacc.append([errorcalc1(root,vs),prunenode])
		return
	r1 = copy.deepcopy(r)
	prune(r);
	newerror = errorcalc1(root,vs) 
	if(error>newerror):
		error = newerror
		prunenode = prunenode + 1;
		pacc.append([error,prunenode])
		r = r1;
		pruning(r.left,vs,error)
		pruning(r.right,vs,error)
		pruning(r.center,vs,error)
	
	else:
		r = r1;
		pruning(r.left,vs,error)
		pruning(r.right,vs,error)
		pruning(r.center,vs,error)



def GrowTree (S,available):
	global firsttime
	global numnodes
	global root
	global gacc
	global tlines
	global testlines
	global vslines

	flag = 0;
	for i in range(len(S)):
		if (S[i][0]=='democrat'):
			flag = 1;
			break
	if ((flag==0)):
	
		leaf = Tree()
		leaf.data = 'republican'
		leaf.S = S
		if(firsttime):
			firsttime = False;
			root = leaf
		#print 'leafa'
		numnodes = numnodes+1
		return leaf
	
	for i in range(len(S)):
		if(S[i][0]=='republican'):
			flag = 0
	if (flag==1):
		leaf = Tree()
		leaf.data = 'democrat'
		leaf.S = S
		if(firsttime):
			firsttime = False;
			root = leaf
		numnodes = numnodes + 1
		return leaf

    
	xj = chooseattr2 (S,available)
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
	if(firsttime):
			firsttime = False;
			root = node
	#error analysis		
	numnodes = numnodes + 1;
			
	nr=0
	nd=0
	qr=0
	qd=0
	yr=0
	yd=0
	for j in range(len(S1)):
		if (S1[j][0]=='republican'):
			nr = nr+1;
		elif (S1[j][0]=='democrat'):
			nd = nd+1;
			
	Jn = 'republican' if (nr>nd) else 'democrat'
	node.data = xj
	node.left = Tree()
	node.left.data = Jn
			
	for j in range(len(S2)):
		if (S2[j][0]=='republican'):
			qr = qr+1;
		elif (S2[j][0]=='democrat'):
			qd = qd+1;
			
	Jq = 'republican' if (qr>qd) else 'democrat'
	node.center = Tree()
	node.center.data = Jq
			
	for j in range(len(S0)):
		if (S0[j][0]=='republican'):
			yr = yr+1;
		elif (S0[j][0]=='democrat'):
			yd = yd+1;
	Jy = 'republican' if (yr>yd) else 'democrat'
	node.right = Tree()
	node.right.data = Jy

	e1=errorcalc1(root,testlines)
	e2=errorcalc1(root,vslines)
	e3=errorcalc1(root,tlines)
	#print e1
	#print e2
	#print e3
	#print numnodes
	
	gacc.append([e1,e2,e3,numnodes])

	#till error calc
			
	node.data = xj
	#print len(S1)
	#print len(S2)
	#print len(S0)
	node.left = GrowTree (S1,available1)
	node.center = GrowTree(S2,available2)
	node.right = GrowTree(S0,available3)
	node.S = S
	return node





		
	
tS = []
vS = []
testS = []
gacc = [];

for i in range(len(tlines)):
	tS.append(str.split(str.strip(tlines[i]),','))

for i in range(len(vslines)):
	vS.append(str.split(str.strip(vslines[i]),','))

#train = GrowTree(tS);

available = range(1,len(tS[0]));
vvss = GrowTree(tS,available);
print vvss.data
print vvss.left.data
print vvss.right.data
print vvss.center.data
print 'hohkdakdh'
print root.data
print root.left.data
print root.right.data
print root.center.data
print 'asda'

#print gacc
gacc.append([errorcalc1(root,testlines),errorcalc1(root,vslines),errorcalc1(root,tlines),numnodes])
f = open ('error4.csv','w')
for i in range(len(gacc)):
	g = gacc[i];
	f.write(str(g[0])+','+str(g[1])+','+str(g[2])+','+str(g[3])+'\n')
f.close
print errorcalc1(root,testlines);
print errorcalc1(root,vslines);
print errorcalc1(root,tlines);
print numnodes;

pacc = []
pruning(root,vslines,1)
print prunenode
print pacc

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
