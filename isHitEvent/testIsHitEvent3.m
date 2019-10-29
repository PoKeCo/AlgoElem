
idxes_size_max=16;
c_idxes     = zeros(idxes_size_max,1);
c_idxes_size= 0;
e_idxes     = zeros(idxes_size_max,1);
e_idxes_size= 0;

'*-------------------------'
for i=1:3
    switch (i)
        case 1
            ego_idx=16;
            [c_idxes,c_idxes_size]=getVectAndSize([7,8,9,10,2],idxes_size_max);
            [e_idxes,e_idxes_size]=getVectAndSize([14,16,7],idxes_size_max);
        case 2
            ego_idx=14;
            [c_idxes,c_idxes_size]=getVectAndSize([7,8,9,10,2],idxes_size_max);
            [e_idxes,e_idxes_size]=getVectAndSize([14,16,7],idxes_size_max);
        case 3
            ego_idx=13;
            [c_idxes,c_idxes_size]=getVectAndSize([7,8,9,10,2],idxes_size_max);
            [e_idxes,e_idxes_size]=getVectAndSize([14,16,7],idxes_size_max);

    end

    hit = isHitEvent(  c_idxes, c_idxes_size, e_idxes, e_idxes_size, ego_idx );
    
    c_idxes(1:c_idxes_size)',e_idxes(1:e_idxes_size)',hit
    %fprintf('---\n%d\n,%d\n,%d\n',c_idxes(1:c_idxes_size)',e_idxes(1:e_idx
    %es_size)',flag);
    %input a;
end
