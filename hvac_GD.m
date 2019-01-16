function [T1_new,T2_new]= hvac_GD(R,C,k,T1,T2,To,Q1,Q2,u1,u2)
% T1_new=T1-k*((T1-To)/0.001 +(T1-T2)/0.001-1005*(u1-T1)-Q1)/74641;  %net heat gain
% T2_new=T2-k*((T2-To)/0.001+(T2-T1)/0.001 -1005*(u2-T1)-Q2)/74641;
% T1_new=T1-k*((T1-To)/0.001 +(T1-T2)/0.001-u1-Q1)/76410;  %net heat gain
% T2_new=T2-k*((T2-To)/0.001+(T2-T1)/0.001-u2-Q2)/76410;
T1_new=T1-k*((T1-To)/R +(T1-T2)/0.0012-u1-Q1)/C;  %net heat gain
T2_new=T2-k*((T2-To)/R+(T2-T1)/0.0012-u2-Q2)/C;
end
