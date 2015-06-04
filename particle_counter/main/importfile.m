function output = importfile(vargin)

if isempty(vargin{1})
    file_to_read = 'photo.jpg';
else
    file_to_read = vargin{1};
end

%% singlePhoto
if strcmp(vargin{2}, 'singlePhoto') == 1
    % import
    if strcmp(vargin{1}(end), 'p') == 1
        temp = importdata(file_to_read);
        raw_image = temp.cdata;
    else
        raw_image = importdata(file_to_read);
    end
    % rgb2gray
    if size(raw_image, 3) == 3
        raw_image_gray_scale = rgb2gray(raw_image);
    else
        raw_image_gray_scale = raw_image;
    end
    % export
    [~, file_name] = fileparts(file_to_read);
    output{1} = raw_image_gray_scale;
    output{2} = file_name;
end

%% video
if strcmp(vargin{2},'video') == 1
    xyloObj = VideoReader('..\Samples\Movie#26 Exp0.2 Gain8 Gamma1.avi');
    number_frames = xyloObj.NumberOfFrames;
    vidHeight = xyloObj.Height;
    vidWidth  = xyloObj.Width;
    mov(1 : number_frames) = ...
        struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),...
               'colormap',[]);
    output = cell(1, number_frames);
    for k = 1 : number_frames
        disp(['progress: ', num2str(k / number_frames * 100), '%'])
        mov(k).cdata = read(xyloObj, k);
        if size(mov(k).cdata, 3) == 3
            output{1, k} = double(rgb2gray(mov(k).cdata));
        end
    end
end

%% imageSeries
if strcmp(vargin{2}, 'imageSeries') == 1 
    output = cell(1, 0);
    for i = 1 : 10
        % import
        file_to_read = [vargin{1},num2str(i),'.jpg'];
        raw_image = importdata(file_to_read);
        % rgb2gray
        if size(raw_image, 3) == 3
            raw_image_gray_scale = rgb2gray(raw_image);
        else
            raw_image_gray_scale = raw_image;
        end
        % export
        output{1,i} = raw_image_gray_scale;
    end
end

end
