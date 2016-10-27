function imgMozaic = construiesteMozaic(params)
%functia principala
%primeste toate datele necesare in structura params


%incarca toate imaginile mici folosite pentru mozaic
if params.database == 1
    params.pieseMozaic = incarcaPieseMozaicBD(params);
else
    params.pieseMozaic = incarcaPieseMozaic(params);
end

%setam dimensiunile pieselor pentru mozaic
params.height = size(params.pieseMozaic(:,:,:,1),1); 
params.width  = size(params.pieseMozaic(:,:,:,1),2); 

%calculeaza noile dimensiuni ale mozaicului
params = calculeazaDimensiuniMozaic(params);

%adauga piese mozaic
imgMozaic = adaugaPieseMozaic(params);