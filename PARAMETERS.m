
%               PARAMETERS
% MPC v 2.1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script initializes the variables needed to run MAIN
% It must be in the same folder as MAIN, to be properly called

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Setting global variables

% boolean
global PARA_useReduced;        % Allows the use of the reduced formulation
global PARA_useSaveData;       % Allows the storage of data during simulation
global PARA_useAnimation;      % Enables the animation at the end of simulation
global PARA_saveFig;           % Allows the save of figure
global PARA_showIter;          % Shows the curent iteration in command window
global PARA_useTorLimMin;      % Enables the use of Minimal Torque Limits
global PARA_useTorLimMax;      % Enables the use of Maximal Torque Limits
global PARA_usePosLimMin;      % Enables the use of Minimal Position Limits
global PARA_usePosLimMax;      % Enables the use of Maximal Position Limits

% string
global PARA_solverSelect       % Select the quadratic solver

% integers
global PARA_N;                 % Length of the time horizon
global PARA_n;                 % Number of DOF (joint space)
global PARA_n_EO;              % Number of DOF (operational space)

% float
global PARA_deltat_simu;       % Time step used by simulation
global PARA_deltat_mpc;        % Time step used by MPC control
global PARA_epsilon;           % Weight of the regularization function
global PARA_omegak;            % Weight of the optimization function
global PARA_kp;                % Proportional gain
global PARA_kd;                % Derivative gain
global PARA_ki;                % Integral gain
global PARA_t0;                % Time of the beginning of the simulation
global PARA_tend;              % Time of the end of the simulation
global PARA_maxVel;            % Maximal velocity used by trajectory generator
global PARA_maxAcc;            % Maximal acceleration used by trajectory generator

% vectors
global PARA_x_des;             % End effector objective
global PARA_q_min;             % Lower positions bounds
global PARA_q_max;             % Upper positions bounds
global PARA_tau_min;           % Lower torque limits
global PARA_tau_max;           % Upper torque limits
global PARA_q_0;               % Initial joint positions
global PARA_dotq_0;            % Initial joint velocities

% SerialLink
global PARA_robot;             % Imported robot model

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calling the Robotic Toolbox (Peter Corke)
run('../rvctools/startup_rvc.m');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Setting global variables

% Control variables
PARA_useReduced = true;
PARA_useSaveData = true;
PARA_useAnimation = false;
PARA_saveFig = false;
PARA_showIter = true;

PARA_solverSelect ='quadprog'; % 'cvx';% 
if ~any(strcmp(PARA_solverSelect,{'quadprog','cvx'}))     % Authorized values of solverSelect are 'quadprog' and 'cvx'
    error('solverSelect value must be quadprog or cvx');  % This if-loop check if the value is correct
end

PARA_useTorLimMin = false;      
PARA_useTorLimMax = false;      
PARA_usePosLimMin = false;      
PARA_usePosLimMax = false; 

% Simulation
PARA_t0 = 0;
PARA_tend = 20.0;
PARA_deltat_simu = 0.01;

% MPC
PARA_deltat_mpc = PARA_deltat_simu;
PARA_N = 0;
PARA_epsilon = 0.1;
PARA_omegak = 1000;

% PID correction
PARA_kp = 1500;
PARA_kd = 2*sqrt(PARA_kp);
PARA_ki = 0;

% Robot model
mdl_puma560;%mdl_onelink;% mdl_twolink;%     % Model must be from the Robotics Toolbox (created or imported)
PARA_robot = p560;%onelink;%twolink;%

if strcmp(PARA_robot.name,'one link')
    
    % Test parameters for R robot
    PARA_n = PARA_robot.n;
    PARA_n_EO = 1;
    
    PARA_q_min = PARA_robot.qlim(:,1)+pi/2;
    PARA_q_max = PARA_robot.qlim(:,2)-pi/2;
    PARA_tau_min = -10;
    PARA_tau_max = 10;
    
    PARA_q_0 = 0.5;
    PARA_dotq_0 = 0;
    PARA_maxVel = 0.5;        
    PARA_maxAcc = NaN;
    PARA_x_des =[0;1];
    
elseif strcmp(PARA_robot.name,'two link')
    
    % Test parameters for RR robot (XZ-plane)
    PARA_n = PARA_robot.n;
    PARA_n_EO = 3;
    
    PARA_q_min = PARA_robot.qlim(:,1)+3*pi/4;
    PARA_q_max = PARA_robot.qlim(:,2)-3*pi/4;
    PARA_tau_min = [-20;-10];
    PARA_tau_max = [20;10];
    
    PARA_q_0 = [0.5;0.5];
    PARA_dotq_0 = [0;0];
    PARA_maxVel = 0.5;        
    PARA_maxAcc = NaN;
    PARA_x_des =[0.2;0;0.5];
    
elseif strcmp(PARA_robot.name,'Puma 560')
    
    % Test parameters for PUMA 560
    PARA_n = PARA_robot.n;
    PARA_n_EO = 6;
    
    PARA_q_min = PARA_robot.qlim(:,1);
    PARA_q_max = PARA_robot.qlim(:,2);
    PARA_tau_min = [-100;-80;-60;-40;-20;-10];
    PARA_tau_max = [100;80;60;40;20;10];
    
    PARA_q_0 = [0.5;0.5;0.5;0.5;0.5;0.5];
    PARA_dotq_0 = [0;0;0;0;0;0];
    PARA_maxVel = 0.5;        
    PARA_maxAcc = NaN;
    PARA_x_des =[0.2;0.3;0.5;0;0;0];
    % If orientation is used, it must be described in RPY convention
end


