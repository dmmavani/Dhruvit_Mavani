% Root directory of this running .m file
projectRootDir = fileparts(mfilename('fullpath'));

% Remove project directories from path
rmpath(fullfile(projectRootDir,genpath('data')));
rmpath(fullfile(projectRootDir,genpath('documents')));
rmpath(fullfile(projectRootDir,genpath('figures')));
rmpath(fullfile(projectRootDir,'functions'));
rmpath(fullfile(projectRootDir,'libraries'));
rmpath(fullfile(projectRootDir,genpath('models')));
rmpath(fullfile(projectRootDir,genpath('scripts')));
rmpath(fullfile(projectRootDir,'work'));


% Reset the loction of Simulink-generated files
Simulink.fileGenControl('reset');

% leave no trace...
clear projectRootDir

