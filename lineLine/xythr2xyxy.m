function [ xyxy ] = xythr2xyxy( xythr )
%xythr2xyxy (x,y,th,r)�ł���킳��钼����(x0,y0,x1,y2)�̍��W�ɕϊ����܂�
%  ���̊֐��̊T��
    xyxy=[ xythr(1)                       , xythr(2)                         ;
           xythr(1)+xythr(4)*cos(xythr(3)), xythr(2)+xythr(4)*sin(xythr(3)) ];
   
end