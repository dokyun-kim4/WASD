% Load and Process Data into Classes
lol_data1 = wasd('data/lol_1.mat');
lol_data1.game = 'League of Legends';
lol_data2 = wasd('data/lol_2.mat');
lol_data2.game = 'League of Legends';
ror_data1 = wasd('data/ror2_1.mat');
ror_data1.game = 'Risk of Rain 2';
ror_data2 = wasd('data/ror2_2.mat');
ror_data2.game = 'Risk of Rain 2';
cs_data1 = wasd('data/cs_1.mat');
cs_data1.game = "Counter Strike 2";
cs_data2 = wasd('data/cs_2.mat');
cs_data2.game = "Counter Strike 2";
tf_data1 = wasd('data/tf_1.mat');
tf_data1.game = "TitanFall 2";
tf_data2 = wasd('data/tf_2.mat');
tf_data2.game = "TitanFall 2";
tf_data3 = wasd('data/tf_3.mat');
tf_data3.game = "TitanFall 2";
fp = wasd('data/frostpunk_1.mat');
fp.game = 'Frostpunk';

%Trim Data
lol_data1.ty = lol_data1.trim(lol_data1.ty,-5.5,2.5);
%Plot Data and Determine Max Freq
max_freq = lol_data1.subplots('y');
%Calculate Score
score_lol = lol_data1.strain_score(max_freq);

%Apply the Same Process to Other Datasets
fp.ty = fp.trim(fp.ty,-3,2);
max_freq = fp.subplots('y');
score_fp = fp.strain_score(max_freq);

ror_data2.ty = ror_data2.trim(ror_data2.ty,-8,-1);
max_freq = ror_data2.subplots('y');
score_ror = fp.strain_score(max_freq);

cs_data2.ty = cs_data2.trim(cs_data2.ty,-10,2);
max_freq = cs_data2.subplots('y');
score_cs = cs_data2.strain_score(max_freq);

tf_data2.ty = tf_data2.trim(tf_data2.ty,-10,2);
max_freq = tf_data2.subplots('y');
score_tf = tf_data2.strain_score(max_freq);