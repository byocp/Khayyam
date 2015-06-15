%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script is made by Kepstrum Inc. Canada
% All rights reserved
% Author: Pedram Ataee
% Date: ??
% Vers: 1.0
% 
% Last edited by: Biye Chen
% Last edited date: Jun. 14, 2015
%
% Description:
% Outputs a frame by frame array of a video file
% 
% Inputs:
%   vidVideo = Selected video file
% 
% Outputs:
%   celFbF = Array of frame by frame of the video
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function celFbF = import_video(vidVideo)
% Grab video properties
objVideo = VideoReader(vidVideo);
intNumFrames = objVideo.NumberOfFrames;
intVidHeight = objVideo.Height;
intVidWidth  = objVideo.Width;

% Initialize blank array
tmpFbF(1:intNumFrames) = struct('cdata', zeros(intVidHeight, intVidWidth, 3, 'uint8'), 'colormap',[]);
celFbF = cell(1, intNumFrames);

h = waitbar(0,'Processing Video: 0%');
set(h, 'WindowStyle','Modal', 'CloseRequestFcn','');
for i = 1:intNumFrames
	waitbar(i/intNumFrames,h,['Processing Video: ' num2str(i/intNumFrames*100,'%3.2f') '%'])
    tmpFbF(i).cdata = read(objVideo, i);
    if size(tmpFbF(i).cdata, 3) == 3
        celFbF{1, i} = double(rgb2gray(tmpFbF(i).cdata));
    end
end
delete(h)