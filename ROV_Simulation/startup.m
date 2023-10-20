% Root directory of this running .m file
projectRootDir = fileparts(mfilename('fullpath'));

% Add project directories to path
addpath(fullfile(projectRootDir,genpath('data')),'-end');
addpath(fullfile(projectRootDir,genpath('documents')),'-end');
addpath(fullfile(projectRootDir,genpath('figures')),'-end');
addpath(fullfile(projectRootDir,'functions'),'-end');
addpath(fullfile(projectRootDir,'libraries'),'-end');
addpath(fullfile(projectRootDir,genpath('models')),'-end');
addpath(fullfile(projectRootDir,genpath('scripts')),'-end');
addpath(fullfile(projectRootDir,'work'),'-end');


% Save Simulink-generated helper files to work
Simulink.fileGenControl('set',...
    'CacheFolder',fullfile(projectRootDir,'work'),...
    'CodeGenFolder',fullfile(projectRootDir,'work'));