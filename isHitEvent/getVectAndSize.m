function [ vect, vect_size ] = Untitled1( ref, max_size )
% Get vector ref's size and value, and, store constant size vect 
    vect                   = zeros( max_size, 1 );
    vect_size              = size( ref, 2 );
    vect( 1:vect_size, 1 ) = ref( 1, 1:vect_size )';
end
