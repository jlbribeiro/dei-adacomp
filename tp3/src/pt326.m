%===================================
%   NAO ALTERAR, pf !!!!
%===================================

function yk = pt326(uk1, uk2, yk1, yk2)
% yk =  0.09*yk1 +0.5*yk2 + 0.2*uk1 ;

yk = yk1;
if yk<10
    yk = 1.1*yk1 /(1.3+0.61*yk1) + 1.19*yk2+ 0.21*uk1 + 0.4*(rand-0.5);
    yk = 0.68*yk;
elseif yk>=10 & yk<30
    yk = 1.1*yk1 /(1.3+0.81*yk1) + 1.19*yk2+ 0.21*uk1 + 0.5*(rand-0.5);
    yk = 0.69*yk;
elseif yk>=30 & yk<40
    yk = 1.1*yk1 /(1.3+0.61*yk1) + 1.19*yk2+ 0.21*uk1 + 0.7*(rand-0.5);
    yk=0.71*yk;
elseif yk>=40
    yk = 1.1*yk1 /(1.3+0.61*yk1) + 1.19*yk2+ 0.21*uk1 + 0.7*(rand-0.5);
    yk= 0.632*yk;
end
yk = 0.75*yk + 0.22*yk1;

if yk<0;  yk=0; end
if yk>50; yk=50; end



