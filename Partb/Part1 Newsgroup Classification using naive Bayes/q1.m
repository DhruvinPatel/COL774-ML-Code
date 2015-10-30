Dic = importdata('dict.txt');
P = importdata ('processed1.txt','',7230);%all data

a = randperm(size(P,1));
sample = P(a,:);

s1 = sample(1 : (7230)*1/5,:);
s2 = sample((7230)*1/5+1:(7230)*2/5,:);
s3 = sample((7230)*2/5+1:(7230)*3/5,:);
s4 = sample((7230)*3/5+1:(7230)*4/5,:);
s5 = sample((7230)*4/5+1:(7230)*5/5,:);

for it = 1:1
   if(it ==1)
       test = s1;
       train = vertcat(s2,s3,s4,s5);
       train = train(1:1000,:);
       
   elseif(it==2)
       train = vertcat(s1,s3,s4,s5);
       test = s2;
       
       
   elseif(it==3)
       train = vertcat(s1,s2,s4,s5);
       test = s3;
       
   elseif(it==4)
       train = vertcat(s1,s2,s3,s5);
       test = s4;
           
   else
       train = vertcat(s1,s2,s3,s4);
       test = s5;
           
   end
   
        classes = {'rec.motorcycles','talk.politics.guns','talk.politics.misc','talk.religion.misc','talk.politics.mideast','rec.sport.hockey','rec.sport.baseball','rec.autos'};
        phi = ones(1,8);
        A = zeros(size(Dic,1),8);
        
        for i = 1:8
            ni = 0;
            sum = 0;
            for j = 1:size(train,1)
                s = train{j};
                ss = strsplit(s);
                if(strcmp(ss(1),classes(i)))
                    sum = sum + 1;
                k = 2
                while( k <((size(ss,2)-1)/2))
                   pos = find(strcmp(Dic,ss(k)));
                   if(size(pos,1)==0)
                       k = k+2;
                            
                   else
                   wik = str2double(ss{k+1});    
                   A(pos,i) = A(pos,i) + wik;
                   ni = ni + wik;
                   k = k+2;
                   end
                   
                end
                
                end
            end
            phi(i) = sum/size(train,1);
            for j = 1:size(Dic,1)
               A(j,i) = (A(j,i)+1)/(ni+size(Dic,1));
                
            end
            
        end
        %saveA = 'A_featurem'
        %saveA = strcat( saveA , int2str(it))

        %savephi = 'phi_feature'
        %savephi = strcat( savephi , int2str(it))
        
        save (strcat('A_featurem1000',int2str(it)), 'A')
        save (strcat('phi_featurem1000',int2str(it)), 'phi')
        
        
        %save 'A_featurem' A
        %save 'phi_feature' phi
        %phi = [0.1323,    0.1253,    0.1060,    0.0877 ,   0.1300  ,  0.1426,    0.1383 ,   0.1378];
        
        
        
        
           
       
   
   
       
       
end



