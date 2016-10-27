function pieseMozaic = incarcaPieseMozaicBD(params)
    load('CIFAR10/test_batch.mat');
    %load('CIFAR10/data_batch_1.mat');
    
    for idxImg=1:size(labels,1)
        if labels(idxImg) == params.category
            image = imrotate(reshape(data(idxImg,:),[32 32 3]),-90);
            
            if params.type == 3
                pieseMozaic(:,:,:,idxImg) = image(:,:,:);
            else
                pieseMozaic(:,:,:,idxImg) = rgb2gray(image(:,:,:));
            end   
        end
    end
end

