pixel = [3,8,13,18,23,28,33,38,43,48,53,58,63,68,73,78,83,88,93,98,103,108,113,118,123,128,133,138,143,148,153,158,163,168,173,178,183,188,193,198,203,208,213,218,223,228,233,238,243,248,253,258,263,268,273,278,283,288,293,298,303,308,313,318,323,328,333,338,343,348,353,358,363,368,373,378,383,388,393,398,403,408,413,418,423,428,433,438,443,448,453,458,463,468,473,478,483,488,493,498,503,508,513,518,523,528,533,538,543,548,553,558,563,568,573,578,583,588,593,598,603,608,613,618,623,628,633,638,643,648,653,658,663,668,673,678,683,688,693,698,703,708,713,718,723,728,733,738,743,748,753,758,763,768,773,778,783];
labels = [1,0,2,0,3,0,4,0,0];

dig = importdata('digitdata.txt');
digl = importdata('digitlabels.txt');
label = digl.data;
digits = dig.data;

a = randperm(size(digits,1));
digits = digits(a,:);
label = label(a,:);

%starting k-means:
meanv = randi([0 60], 4,157);
%meanv(1,:) = digits(1,:);
%meanv(2,:) = digits(2,:);
%meanv(3,:) = digits(3,:);
%meanv(4,:) = digits(5,:);

%meanv(1,:) = digits(randi([0 1000]),:);
%meanv(2,:) = digits(randi([0 1000]),:);
%meanv(3,:) = digits(randi([0 1000]),:);
%meanv(4,:) = digits(randi([0 1000]),:);


cluster = randi([1 4], size(digits,1),1);

errorvsit = zeros(30,1);
S = zeros(30,1);

it = 1;
while(it<30)
    disp(it);
    
    %assigning clusters
    for i = 1:size(digits,1)
       xi = digits(i,:);
       
       d = xi-meanv(1,:);
       d1 = d*d';
       
       d = xi-meanv(2,:);
       d2 = d*d';
       
       d = xi-meanv(3,:);
       d3 = d*d';
       
       d = xi-meanv(4,:);
       d4 = d*d';
       
       [v index] = min([d1,d2,d3,d4]);
       cluster(i) = index;
              
    end
    
    %label assigning part
    
    cl = zeros(4,4);
    
    for i = 1:size(digits,1)
       xci = cluster(i);
       xl = labels(label(i));
       cl(xci,xl) = cl(xci,xl)+1;
    end
    
    for j=1:4
        [val index] = max(cl(j,:));
        errorvsit(it,1) = errorvsit(it,1) + (cl(j,1)+cl(j,2)+cl(j,3)+cl(j,4)) - val;        
    end
    errorvsit(it,1) = errorvsit(it,1)/size(digits,1);
    
    disp('cl:');
    disp(cl);
    
    for j = 1:4
        sum = zeros(1,157);
        n = 0;
       for i=1:size(digits,1)
           if(cluster(i)==j)
              sum = sum + digits(i,:);
              n = n+1;
           end
       end
       meanv(j,:) = sum/n;   
    end
    
    %for calculating S
    for i = 1:size(digits,1)
        xi = digits(i,:);
        uki = meanv(cluster(i),:);
       S(it,1) = S(it,1) + (xi-uki)*(xi-uki)'; 
    end
   it = it +1; 
end

disp('error:');
%disp(errorvsit);

