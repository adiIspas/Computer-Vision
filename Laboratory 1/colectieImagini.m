function [ imgColor, imgGray, X ] = colectieImagini(dirPath, set)
    path = strcat(dirPath, set);
    filelist = dir(path);
    
    init = 0;
    for idxImg = 3:length(filelist)
        imgName = filelist(idxImg).name;
        nextImg = imread(strcat(path,imgName));
        grayNextImg = rgb2gray(nextImg);
        
        if init == 0
            first_image = zeros(size(nextImg),'uint16');
            second_image = zeros(size(grayNextImg),'uint16');
            tree_image = zeros(size(grayNextImg),'uint16');
            n_tree_image = zeros(length(filelist) - 2, size(grayNextImg,1), size(grayNextImg,2),'uint16');
            
            init = 1;
        end
        
        first_image(:,:) = first_image(:,:) + uint16(nextImg(:,:));
        second_image(:,:) = second_image(:,:) + uint16(grayNextImg(:,:));
        n_tree_image(idxImg,:,:) = uint16(grayNextImg(:,:));
        
        %imshow(nextImg)
    end
    
    first_image(:,:) = round(first_image(:,:)/(length(filelist) - 2));
    second_image(:,:) = round(second_image(:,:)/(length(filelist) - 2));
    tree_image(:,:) = std(double(n_tree_image(:,:,:)));
    
    imgColor = uint8(first_image);
    imgGray = uint8(second_image);
    X = uint8(tree_image);
end

