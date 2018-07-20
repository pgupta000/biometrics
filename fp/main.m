clear; clc;
addpath(genpath(pwd));
dbxls = exist('database.xlsx', 'file');
if(dbxls==0)
    xlswrite('database.xlsx',{'ID'}, 1, 'A1');
    xlswrite('database.xlsx',{'NAME'}, 1, 'B1');
    xlswrite('database.xlsx',{'AGE'}, 1, 'C1');
    xlswrite('database.xlsx',{'EMAIL'}, 1, 'D1');
    xlswrite('database.xlsx',{'PHONE'}, 1, 'E1');
    xlswrite('database.xlsx',{'ID'}, 2, 'A1');
end

while 1<2
    disp('Welcome');
    disp('1) Fingerprint Enrollment');
    disp('2) Fingerprint Attendence');
    op=input('Enter Your Choice: ');
    
    
    switch op
        case 1
            disp('Admin''s Fingerprint:');
            %% EXTRACT FEATURES FROM AN ARBITRARY FINGERPRINT
            filename='101_1.tif';
            img = imread(filename);
            if ndims(img) == 3; img = rgb2gray(img); end  % Color Images
            disp(['Extracting features from ' filename ' ...']);
            ffadm=ext_finger(img,0);
            %%COMPARES FINGERPRINT WITH ADMIN DATABASE
            load('adm.mat'); i=0;
            while i < n_dbadm
                i=i+1;
                disp(['Searching Admin Database...']);
                S=match(ffadm,dbadm{i},0);
                if S>=0.48
                    disp('Fingerprint Matched');
                    disp('Access Granted');
                    break
                end
                
            end
            if S>=0.48
                %%enrollment
                addpath('FVC2002\DB1_B');
                fchk = exist('cdn.mat','file');
                if (fchk==0)
                    save('cdn.mat');
                end
                load('cdn.mat');
                chk = exist('dbcdn', 'var');
                if(chk == 0)
                    dbcdn = {};
                end
                disp('Enter Student''s Details:-');
                nm = input('Name:', 's');
                ag = input('Age:', 's');
                em = input('Email:', 's');
                ph = input('Mobile No.:', 's');
                for lp = 1:8
                    disp('Keep finger print in eight different orientations:');
                    [m, n_dbcdn] = size(dbcdn);
                    filename='101_1.tif';
                    img = imread(filename);
                    if ndims(img) == 3; img = rgb2gray(img); end  % Color Images
                    disp(['Extracting Features From fingerprint...']);
                    enrx = ext_finger(img,0);
                    dbcdn{1, n_dbcdn + 1} = enrx;
                    n_cdn = n_dbcdn + 1;
                    save('cdn.mat', 'dbcdn', 'n_dbcdn' );
                    disp('Fingerprint Enrolled Succesfully');
                end
                xlswrite('database.xlsx',{num2str(fix((n_cdn - 1)/8)+1)}, 1, ['A' num2str(fix((n_cdn - 1)/8)+2)]);     
                xlswrite('database.xlsx',{nm}, 1, ['B' (num2str(fix((n_cdn - 1)/8)+1)) + 1 ]);
                xlswrite('database.xlsx',{ag}, 1, ['C' (num2str(fix((n_cdn - 1)/8)+1)) + 1 ]);
                xlswrite('database.xlsx',{em}, 1, ['D' (num2str(fix((n_cdn - 1)/8)+1)) + 1 ]);
                xlswrite('database.xlsx',{ph}, 1, ['E' (num2str(fix((n_cdn - 1)/8)+1)) + 1 ]);
                xlswrite('database.xlsx',{num2str(fix((n_cdn - 1)/8)+1)}, 2, ['A' num2str(fix((n_cdn - 1)/8)+2)]);
                disp(['New Entry Added with ID no. ' num2str(fix((n_cdn - 1)/8)+1) ' and name ' nm ]);
            else
                disp('Access Denied');
            end
            
            
            
            
            
            
        case 2
            n=input('Enter your ID: ');
            
            filename='103_1.tif';
            img = imread(filename);
            if ndims(img) == 3; img = rgb2gray(img); end  % Color Images
            disp(['Extracting features from ' filename ' ...']);
            ffcdn=ext_finger(img,0);
            load('cdn.mat'); i=0;
            i = (n-1)*8;
            while i < n_dbcdn
                i=i+1;
                disp(['Searching Students Database...']);
                Sc=match(ffcdn,dbcdn{i},0);
                if Sc>=0.48
                    disp(['Fingerprint Matched with a similarity score of ' num2str(Sc) ]);
                    break
                end
            end
            if Sc>=0.48
                id = fix((i-1)/8)+1;
                x = days(datetime('today') - datetime('16-Jun-2018'));
                xlswrite('database.xlsx',{date}, 2, num2col(x+2));
                r = [num2col(x+2) num2str(id +1)];
                xlswrite('database.xlsx',{'P'}, 2, r);
                [num,txt,raw] = xlsread('database.xlsx', 1 , ['B' num2str(id + 1)]);
                disp(strjoin(['WELCOME ' raw]));
                disp('Attendence Added');
                break
            end
            if Sc<=0.6
                disp('Fingerprint does not match');
                disp('Try Again');
                
                
            end
            
            
            
            
        case 3
            
            exit;
            
        otherwise
            disp('Incorrect Option. Try Again..');
            clc;
    end
end