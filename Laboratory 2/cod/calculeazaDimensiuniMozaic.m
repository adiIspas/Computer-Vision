function params = calculeazaDimensiuniMozaic(params)
%calculeaza dimensiunile mozaicului
%obtine si imaginea de referinta redimensionata avand aceleasi dimensiuni
%ca mozaicul

image = params.imgReferinta;

% aspect ration
%new_width = params.numarPieseMozaicOrizontala * 40;
new_width = params.numarPieseMozaicOrizontala * params.width;
% pentru determinarea numarul de piese ale mozaciului pe verticala 
% folosim formula: old_height / old_width * new_width
new_height = uint32(size(params.imgReferinta,1)/size(params.imgReferinta,2) * new_width);

%calculeaza automat numarul de piese pe verticala
%params.numarPieseMozaicVerticala = uint32(new_height / 30);
params.numarPieseMozaicVerticala = uint32(new_height / params.height);

% actualizam height
%new_height = params.numarPieseMozaicVerticala * 30;
new_height = params.numarPieseMozaicVerticala * params.height;


params.imgReferintaRedimensionata = imresize(image,[new_height new_width],'bicubic');