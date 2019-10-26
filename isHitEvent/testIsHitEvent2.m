
idxes_size_max=16;
c_idxes     = zeros(idxes_size_max,1);
c_idxes_size= 0;
e_idxes     = zeros(idxes_size_max,1);
e_idxes_size= 0;

'*-------------------------'
for i=8:12
    switch (i)
        case 0
            ego_idx=1;
            [c_idxes,c_idxes_size]=getVectAndSize([1,2,3,4],idxes_size_max);
            [e_idxes,e_idxes_size]=getVectAndSize([-1,0,1],idxes_size_max);
        case 1
            ego_idx=1;
            [c_idxes,c_idxes_size]=getVectAndSize([1,2,3,4],idxes_size_max);
            [e_idxes,e_idxes_size]=getVectAndSize([0,1,2],idxes_size_max);
        case 2
            ego_idx=1;
            [c_idxes,c_idxes_size]=getVectAndSize([1,2,3,4],idxes_size_max);
            [e_idxes,e_idxes_size]=getVectAndSize([1,2,3],idxes_size_max);
        case 3
            ego_idx=1;
            [c_idxes,c_idxes_size]=getVectAndSize([1,2,3,4],idxes_size_max);
            [e_idxes,e_idxes_size]=getVectAndSize([2,3,4],idxes_size_max);
        case 4
            ego_idx=1;
            [c_idxes,c_idxes_size]=getVectAndSize([1,2,3,4],idxes_size_max);
            [e_idxes,e_idxes_size]=getVectAndSize([3,4,5],idxes_size_max);
        case 5
            ego_idx=1;
            [c_idxes,c_idxes_size]=getVectAndSize([1,2,3,4],idxes_size_max);
            [e_idxes,e_idxes_size]=getVectAndSize([4,5,6],idxes_size_max);
        case 6
            ego_idx=1;
            [c_idxes,c_idxes_size]=getVectAndSize([1,2,3,4],idxes_size_max);
            [e_idxes,e_idxes_size]=getVectAndSize([5,6,7],idxes_size_max);
        case 7
            ego_idx=1;
            [c_idxes,c_idxes_size]=getVectAndSize([1,2,3,4],idxes_size_max);
            [e_idxes,e_idxes_size]=getVectAndSize([5,1,2],idxes_size_max);

        case 8
            ego_idx=1;
            [c_idxes,c_idxes_size]=getVectAndSize([1,2,3],idxes_size_max);
            [e_idxes,e_idxes_size]=getVectAndSize([1,2,3],idxes_size_max);
        case 9
            ego_idx=1;
            [c_idxes,c_idxes_size]=getVectAndSize([1,2],idxes_size_max);
            [e_idxes,e_idxes_size]=getVectAndSize([1,2,3],idxes_size_max);
        case 10
            ego_idx=2;
            [c_idxes,c_idxes_size]=getVectAndSize([2,3],idxes_size_max);
            [e_idxes,e_idxes_size]=getVectAndSize([1,2,3],idxes_size_max);
        case 11
            ego_idx=1;
            [c_idxes,c_idxes_size]=getVectAndSize([1,2,3],idxes_size_max);
            [e_idxes,e_idxes_size]=getVectAndSize([1,4,5],idxes_size_max);
        case 12
            ego_idx=1;
            [c_idxes,c_idxes_size]=getVectAndSize([1,2,3],idxes_size_max);
            [e_idxes,e_idxes_size]=getVectAndSize([1,2,3],idxes_size_max);

    end

    hit = isHitEvent(  c_idxes, c_idxes_size, e_idxes, e_idxes_size, ego_idx );
    
    c_idxes(1:c_idxes_size)',e_idxes(1:e_idxes_size)',hit
    %fprintf('---\n%d\n,%d\n,%d\n',c_idxes(1:c_idxes_size)',e_idxes(1:e_idx
    %es_size)',flag);
    %input a;
end
