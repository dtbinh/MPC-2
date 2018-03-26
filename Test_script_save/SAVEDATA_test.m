
%                       SAVEDATA_test
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This script is a test version of the SAVEDATA element
% it is linked to the PARAMETERS_save file

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%call global
%PARA
global PARA_useReduced;

global PARA_deltat_simu;

global PARA_q_min;
global PARA_q_max;
global PARA_tau_min;
global PARA_tau_max;

global PARA_robot;

%MAIN
global MAIN_invM;
global MAIN_J;
global MAIN_dotJ;

global MAIN_b;
global MAIN_g;
global MAIN_dotq;
global MAIN_q;

%MPC
global MPC_tau_app;
global MPC_khi_app;

%TASK
global TASK_ddotx_N;
global TASK_x_des;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Initialization
% save_tau_all = [];
% save_tau_minall = [];
% save_tau_maxall = [];
% save_ddotq_all = [];
% save_dotq_all = [];
% save_q_all = [];
% save_ddotq_minposall = [];
% save_ddotq_maxposall = [];
% save_ddotx_all = [];
% save_ddotx_desall =[];
% save_x_all =[];
% save_x_desall = []; %WILL BE GLOBAL BECAUSE NEED TO BE UPDATE AT EACH ITERATION

global SAVE_tau_all;
global SAVE_tau_minall;
global SAVE_tau_maxall;
global SAVE_ddotq_all;
global SAVE_dotq_all;
global SAVE_q_all;
global SAVE_ddotq_minposall;
global SAVE_ddotq_maxposall;
global SAVE_ddotx_all;
global SAVE_ddotx_desall;
global SAVE_x_all
global SAVE_x_desall;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PARA_useReduced
    SAVE_tau_all=[SAVE_tau_all, MPC_tau_app];
    SAVE_tau_minall = [SAVE_tau_minall, PARA_tau_min];
    SAVE_tau_maxall = [SAVE_tau_maxall, PARA_tau_max];
    SAVE_ddotq_all=[SAVE_ddotq_all, MAIN_invM*(MPC_tau_app - MAIN_b - MAIN_g)];
    SAVE_dotq_all=[SAVE_dotq_all, MAIN_dotq];
    SAVE_q_all = [SAVE_q_all, MAIN_q];
    SAVE_ddotq_minposall = [SAVE_ddotq_minposall, 2/(PARA_deltat_simu^2.0)*(PARA_q_min-MAIN_q-PARA_deltat_simu*MAIN_dotq)];
    SAVE_ddotq_maxposall = [SAVE_ddotq_maxposall, 2/(PARA_deltat_simu^2.0)*(PARA_q_max-MAIN_q-PARA_deltat_simu*MAIN_dotq)];
    SAVE_ddotx_all = [SAVE_ddotx_all, MAIN_J*MAIN_invM*(MPC_tau_app - MAIN_b - MAIN_g) + MAIN_dotJ];
    SAVE_ddotx_desall=[SAVE_ddotx_desall, TASK_ddotx_N(:,1)];
    x = PARA_robot.fkine(MAIN_q);
    SAVE_x_all=[SAVE_x_all,x(1:3,4)];
    SAVE_x_desall=[SAVE_x_desall, TASK_x_des];
else
    SAVE_tau_all=[SAVE_tau_all, MPC_khi_app(1:6,1)];
    SAVE_tau_minall = [SAVE_tau_minall, PARA_tau_min];
    SAVE_tau_maxall = [SAVE_tau_maxall, PARA_tau_max];
    SAVE_ddotq_all=[SAVE_ddotq_all, MPC_khi_app(7:12,1)];
    SAVE_dotq_all=[SAVE_dotq_all, MAIN_dotq];
    SAVE_q_all = [SAVE_q_all, MAIN_q];
    SAVE_ddotq_minposall = [SAVE_ddotq_minposall, 2/(PARA_deltat_simu^2.0)*(PARA_q_min-MAIN_q-PARA_deltat_simu*MAIN_dotq)];
    SAVE_ddotq_maxposall = [SAVE_ddotq_maxposall, 2/(PARA_deltat_simu^2.0)*(PARA_q_max-MAIN_q-PARA_deltat_simu*MAIN_dotq)];
    SAVE_ddotx_all = [SAVE_ddotx_all, MAIN_J*MAIN_invM*(MPC_tau_app - MAIN_b - MAIN_g) + MAIN_dotJ];
    SAVE_ddotx_desall=[SAVE_ddotx_desall, TASK_ddotx_N(:,1)];
    x = PARA_robot.fkine(MAIN_q);
    SAVE_x_all=[SAVE_x_all,x(1:3,4)];
    SAVE_x_desall=[SAVE_x_desall, TASK_x_des];
end

%save_out={save_tau_all,save_tau_minall,save_tau_maxall,save_ddotq_all,save_dotq_all,save_q_all,save_ddotq_minposall,save_ddotq_minposall,save_ddotx_all,save_ddotx_desall,save_x_all,save_x_desall};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PARA
% disp(PARA_useReduced);
% 
% disp(PARA_deltat_simu);
% 
% disp(PARA_q_min);
% disp(PARA_q_max);
% disp(PARA_tau_min);
% disp(PARA_tau_max);
% 
% disp(PARA_robot);
% 
% %MAIN
% disp(MAIN_invM);
% disp(MAIN_J);
% disp(MAIN_dotJ);
% 
% disp(MAIN_b);
% disp(MAIN_g);
% disp(MAIN_dotq);
% disp(MAIN_q);
% 
% %MPC
% disp(MPC_tau_app);
% disp(MPC_khi_app);
% 
% %TASK
% disp(TASK_ddotx_N);
% disp(TASK_x_des);