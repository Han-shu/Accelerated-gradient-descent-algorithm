function [T1_new,T2_new,T1_gd1,T2_gd1]= hvac_AGD(R,C,i,k,T1,T2,T1_gd2,T2_gd2,To,Q1,Q2,u1,u2)
T1_gd1=T1-k*((T1-To)/R +(T1-T2)/0.0012 - u1 -Q1)/C;
T2_gd1=T2-k*((T2-To)/R +(T2-T1)/0.0012 - u2 -Q2)/C;
T1_new=T1_gd1+((i-2)/(i+1))*(T1_gd1-T1_gd2); 
T2_new=T2_gd1+((i-2)/(i+1))*(T2_gd1-T2_gd2); 
end