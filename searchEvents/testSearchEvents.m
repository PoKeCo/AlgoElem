addpath('../isHitEvent/');
%testIsHitEvent2

idxes_size_max=16;

c_idxes     = zeros(idxes_size_max,1);
c_idxes_size= 0;
e_count     = 5;
e_idxes      = zeros(idxes_size_max,e_count);
e_idxes_sizes= zeros(             1,e_count);

ego_idx=1;            
[c_idxes,c_idxes_size]=getVectAndSize([1,2,3,4],idxes_size_max);
[e_idxes(:,1),e_idxes_sizes(1,1)]=getVectAndSize([0,1,2],idxes_size_max);
[e_idxes(:,2),e_idxes_sizes(1,2)]=getVectAndSize([1,2,3],idxes_size_max);
[e_idxes(:,3),e_idxes_sizes(1,3)]=getVectAndSize([2,3,4],idxes_size_max);
[e_idxes(:,4),e_idxes_sizes(1,4)]=getVectAndSize([3,4,5],idxes_size_max);
[e_idxes(:,5),e_idxes_sizes(1,5)]=getVectAndSize([3,4,6],idxes_size_max);
c_idxes(1:c_idxes_size)'

hit=zeros(1,e_count)
for i=1:e_count
    hit(1,i) = isHitEvent(  c_idxes(:,1), c_idxes_size, e_idxes(:,i), e_idxes_sizes(i), ego_idx );
    %e_idxes(1:e_idxes_size,i)',hit(1,i) 
end
e_idxes, hit