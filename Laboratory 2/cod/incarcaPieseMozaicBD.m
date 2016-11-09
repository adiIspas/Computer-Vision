function pieseMozaic = incarcaPieseMozaicBD(params)
    load('CIFAR10/test_batch.mat');
    %load('CIFAR10/data_batch_1.mat');

    idxOk = 1;
    for idxImg=1:size(labels,1)
        if labels(idxImg) == params.category
            image = imrotate(reshape(data(idxImg,:),[32 32 3]),-90);

            if params.type == 3
                pieseMozaic(:,:,:,idxOk) = image(:,:,:);
            else
                pieseMozaic(:,:,:,idxOk) = rgb2gray(image(:,:,:));
            end
            
            idxOk = idxOk + 1;
        end
    end
end
