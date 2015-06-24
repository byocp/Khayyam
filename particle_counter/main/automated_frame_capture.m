function imgRaw = automated_frame_capture(dblExposure, dblGain, dblGamma)
    % This function set the minimal camera parameters using the API functions

    % Set the number of camers
    numCam = 1;
    % Open camera
    camConnect = LucamCameraOpen(numCam);

    if camConnect ~= -1
        % Adjust level of gain
        LucamSetGain(dblGain, 1);
        % Set exposure
        LucamSetSnapshotExposure(dblExposure, 1);
        % Set Gamma
        LucamSetGamma(dblGamma, 1);
        % Take the first snap shot.
        imgRaw = LucamTakeSnapshot(numCam);
        % Close camera.
        LucamCameraClose(numCam);
    else
        imgRaw = -1;
    end

end
