function params = calculeazaDimensiuniMozaic(params)
%calculeaza dimensiunile mozaicului
%obtine si imaginea de referinta redimensionata avand aceleasi dimensiuni
%ca mozaicul

%completati codul Matlab
image = params.imgReferinta;

% aspect ration
new_width = params.numarPieseMozaicOrizontala * 40;
new_height = uint32(size(params.imgReferinta,1)/size(params.imgReferinta,2) * new_width); % old_height / old_width * new_width

%calculeaza automat numarul de piese pe verticala
params.numarPieseMozaicVerticala = uint32(new_height / 30);

% update height
new_height = params.numarPieseMozaicVerticala * 30;

params.imgReferintaRedimensionata = imresize(image,[new_height new_width],'bicubic');