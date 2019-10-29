function [hit]=isHitEvent( c_idxes, c_idxes_size, e_idxes, e_idxes_size, ego_idx )
% Check that c_idxes contains e_idxes's path
    
    %% Backword check 
    c_first_idx = c_idxes(1);
    % Set hit flag 
    hit=1;
    for e_ptr=e_idxes_size:-1:1
        e_idx=e_idxes(e_ptr);
        find_e_idx_in_c_idxes=0;
        % Find e_idx in c_idxes
        for c_ptr=c_idxes_size:-1:1
            c_idx=c_idxes(c_ptr);
            % If find e_idx then set the flag and finish the search.
            if( c_idx == e_idx )
                find_e_idx_in_c_idxes = 1;
                break;
            end
            % If reach to ego_idx then finish the search
            if( c_idx == ego_idx )
                break;
            end
        end
        % If e_idx was not fond in c_idxes then hit=0 and finished. 
        if( find_e_idx_in_c_idxes == 0 )
            hit = 0;
            break; % If hit = 0 once, search finish. 
        end
        % If e_idx is reach to ego_idx then finish the search.
        if( e_idx == ego_idx || e_idx == c_first_idx )
            break;
        end
    end    
            
end