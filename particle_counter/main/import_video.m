function output = import_video(file_to_read)
%% video
xyloObj = VideoReader(file_to_read);
number_frames = xyloObj.NumberOfFrames;
vidHeight = xyloObj.Height;
vidWidth  = xyloObj.Width;
mov(1 : number_frames) = struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'), 'colormap',[]);
output = cell(1, number_frames);
for k = 1 : number_frames
    disp(['progress: ', num2str(k / number_frames * 100), '%'])
    mov(k).cdata = read(xyloObj, k);
    if size(mov(k).cdata, 3) == 3
        output{1, k} = double(rgb2gray(mov(k).cdata));
    end
end
