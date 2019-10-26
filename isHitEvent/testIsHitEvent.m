
idxes_size_max=16;
c_idxes     = zeros(idxes_size_max,1);
c_idxes_size= 0;
e_idxes     = zeros(idxes_size_max,1);
e_idxes_size= 0;

'*-------------------------'
for i=1:10
    switch (i)
        case 1
            ego_idx=1;
            [c_idxes,c_idxes_size]=getVectAndSize([1,2,3,4],idxes_size_max);
            [e_idxes,e_idxes_size]=getVectAndSize([1,2,3],idxes_size_max);
        case 2
            ego_idx=1;
            [c_idxes,c_idxes_size]=getVectAndSize([1,2,3,4],idxes_size_max);
            [e_idxes,e_idxes_size]=getVectAndSize([1,2],idxes_size_max);
        case 3
            ego_idx=1;
            [c_idxes,c_idxes_size]=getVectAndSize([1,2,3,4],idxes_size_max);
            [e_idxes,e_idxes_size]=getVectAndSize([2,3],idxes_size_max);
        case 4
            ego_idx=1;
            [c_idxes,c_idxes_size]=getVectAndSize([1,2,3,4],idxes_size_max);
            [e_idxes,e_idxes_size]=getVectAndSize([1,2,5],idxes_size_max);
        case 5
            ego_idx=1;
            [c_idxes,c_idxes_size]=getVectAndSize([1,2,3,4],idxes_size_max);
            [e_idxes,e_idxes_size]=getVectAndSize([0,1,2],idxes_size_max);
        case 6
            ego_idx=1;
            [c_idxes,c_idxes_size]=getVectAndSize([1,2,3,4],idxes_size_max);
            [e_idxes,e_idxes_size]=getVectAndSize([5,4,1],idxes_size_max);
        case 7
            ego_idx=1;
            [c_idxes,c_idxes_size]=getVectAndSize([1,2,3,4,5],idxes_size_max);
            [e_idxes,e_idxes_size]=getVectAndSize([9,4,5],idxes_size_max);
        case 8
            ego_idx=1;
            [c_idxes,c_idxes_size]=getVectAndSize([1,2,3,4,5],idxes_size_max);
            [e_idxes,e_idxes_size]=getVectAndSize([9,2,3],idxes_size_max);
        case 9
            ego_idx=1;
            [c_idxes,c_idxes_size]=getVectAndSize([1,2,3,4,5],idxes_size_max);
            [e_idxes,e_idxes_size]=getVectAndSize([0,1,2],idxes_size_max);
        case 10
            ego_idx=1;
            [c_idxes,c_idxes_size]=getVectAndSize([1,2,3,4,5],idxes_size_max);
            [e_idxes,e_idxes_size]=getVectAndSize([4,5,6],idxes_size_max);
    end

    hit = isHitEvent(  c_idxes, c_idxes_size, e_idxes, e_idxes_size, ego_idx );
    
    c_idxes(1:c_idxes_size)',e_idxes(1:e_idxes_size)',hit
    %fprintf('---\n%d\n,%d\n,%d\n',c_idxes(1:c_idxes_size)',e_idxes(1:e_idxes_size)',flag);
end
