%Have used the same format of output as provided by Professor.

% 1.  build model
t = cputime;
[model,avg,eigenfaces] = build_model ();
fprintf ( 'Build model time = %f sec\n', cputime-t);


% 2.  test each image

% (1) load GT
gt = csvread ( 'unknown/gt.csv' );

% (2) test on unknown images
pt = 0;

t = cputime;

for i = 1:35
    fn = sprintf ( 'unknown/%d.gif',i);
    f = imread ( fn );%read each unknown image
    alg_id = who_am_i ( model, f , avg , eigenfaces );%while testing,
                                                    %we call who_am_i function.
                                                    %this function takes
                                                    %model, unknown image,
                                                    %mean and eigenfaces as
                                                    %parameters.
    
    if ( gt(i) == alg_id )%if the id stored in the csv file and the id 
                            %recognized by the who_m_i funtion is the
                            %same.then points are alloted.
        pt = pt + 1;
    end
    
    fprintf ( '%d - alg(%d) vs gt(%d) - %f sec -> total pt [%d]\n', ...
        i, alg_id, gt(i), cputime-t, pt );
end

fprintf ( 'final accuracy = %d / %d = %f\n', ...
    pt, 35, (double(pt)/double(35)) );
