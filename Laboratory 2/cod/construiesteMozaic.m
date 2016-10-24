function imgMozaic = construiesteMozaic(params)
%functia principala
%primeste toate datele necesare in structura params


%incarca toate imaginile mici folosite pentru mozaic
params.pieseMozaic = incarcaPieseMozaic(params);

%calculeaza noile dimensiuni ale mozaicului
params = calculeazaDimensiuniMozaic(params);

%adauga piese mozaic
imgMozaic = adaugaPieseMozaic(params);