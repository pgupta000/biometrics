clear
addpath('FVC2002\DB1_B');
fchk = exist('adm.mat','file');
if (fchk==0)
    save('adm.mat');
end
load('adm.mat');
chk = exist('dbadm', 'var');
if(chk == 0)
    dbadm = {};
end
[m, n_dbadm] = size(dbadm);
filename='101_1.tif';
img = imread(filename);
if ndims(img) == 3; img = rgb2gray(img); end  % Color Images
disp(['Extracting Features From fingerprint...']);
x = ext_finger(img,0);
dbadm{1, n_dbadm + 1} = x;
n_dbadm = n_dbadm + 1;
save('adm.mat', 'dbadm', 'n_dbadm' );