clear all;
load('parameter2');
%% staircase parameters 12 points(10mins 2 hours)
R=0.006;
C=16410;
stair_t=zeros(1,12);
stair_Q1=zeros(1,12);
stair_Q2=zeros(1,12);
j=0;
for i=1:10:120
    j=j+1;
    stair_t(1,j)=temp2(i,1);
    stair_Q1(1,j)=temp2(i,2);
    stair_Q2(1,j)=temp2(i,3);
end
figure(1);
stairs(stair_t);
stair_t(1,1)=23.2;
set_u1=zeros(1,12);
set_u2=zeros(1,12);
%set_u=[23 23.2 23.4 23.6 23.8 24 24 23.8 23.6 23.4 23.2 23];
set_u=[23 23.2 23.4 23.6 23.8 24 24.2 24.4 24.6 24.8 25 25.2];
figure(2);
stairs(set_u,'k');
hold on;
for i=1:12
    set_u1(1,i)= (set_u(1,i)-stair_t(1,i))/R-stair_Q1(1,i);
    set_u2(1,i)= (set_u(1,i)-stair_t(1,i))/R-stair_Q2(1,i);
end
% hold on;
% line([0,13],[24,24]);
% axis([0,12,23.9,24.1]);
hold on;
k=0.1;
HVAC_GD=zeros(12000,2);

for m=1:12
    To=stair_t(1,m)+273.15;
    Q1=stair_Q1(1,m);
    Q2=stair_Q2(1,m);
    u1=set_u1(1,m);
    u2=set_u2(1,m);
    n=1000*(m-1);
    if n > 1
        HVAC_GD(n+1,1)=HVAC_GD(n,1);  % initialization 
        HVAC_GD(n+1,2)=HVAC_GD(n,1);
    else 
        HVAC_GD(1,1)=To;  % initialization 
        HVAC_GD(1,2)=To;
    end
    for i=2:1000
        r=i+n;
        j=r-1;
        [HVAC_GD(r,1),HVAC_GD(r,2)]=hvac_GD(R,C,k,HVAC_GD(j,1),HVAC_GD(j,2),To,Q1,Q2,u1,u2);
    end
end

plot([1.001:0.001:13],[HVAC_GD(:,1)-273.15,HVAC_GD(:,2)-273.15],'b'); 
hold on;
%% AGD 
HVAC_AGD=zeros(12000,4);
for m=1:12
    To=stair_t(1,m)+273.15;
    Q1=stair_Q1(1,m);
    Q2=stair_Q2(1,m);
    u1=set_u1(1,m);
    u2=set_u2(1,m);
    n=1000*(m-1);
    if n > 1
        HVAC_AGD(n+1,1)=HVAC_AGD(n,1);  % initialization 
        HVAC_AGD(n+1,2)=HVAC_AGD(n,2);
        HVAC_AGD(n+1,3)=HVAC_AGD(n,3);  % initialization 
        HVAC_AGD(n+1,4)=HVAC_AGD(n,4);
    else 
        HVAC_AGD(1,1)=To;  % initialization 
        HVAC_AGD(1,2)=To;
        HVAC_AGD(1,3)=To; 
        HVAC_AGD(1,4)=To;
    end
    for i=2:1000
        r=i+ n;
        j=r-1;
        %[T1_new,T2_new,T1_gd1,T2_gd1]= hvac_AGD(i,k,T1,T2,T1_gd2,T2_gd2,To,Q1,Q2,u1,u2)
        [HVAC_AGD(r,1),HVAC_AGD(r,2),HVAC_AGD(r,3),HVAC_AGD(r,4)]=hvac_AGD(R,C,i,k,HVAC_AGD(j,1),HVAC_AGD(j,2),HVAC_AGD(j,3),HVAC_AGD(j,4),To,Q1,Q2,u1,u2);
    end
end
plot([1.001:0.001:13],[HVAC_AGD(:,1)-273.15],'r'); 
hold off;
legend('To','T1_{GD}','T1_{AGD}');