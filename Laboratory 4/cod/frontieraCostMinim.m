function [ imgSintetizata ] = frontieraCostMinim( params )
    % Imaginea texturii se completeaza cu blocuri bazare pe eroare de suprapunere
    % si a frontiere de cost minim.

    % Setam parametrii de intrare
    nrBlocuriY            = params.nrBlocuriY;
    nrBlocuriX            = params.nrBlocuriX;
    nrBlocuri             = params.nrBlocuri;
    dimBloc               = params.dimBloc;
    imgSintetizataMaiMare = params.imgSintetizataMaiMare;
    imgSintetizata        = params.imgSintetizata;
    blocuri               = params.blocuri;
    pixeli                = params.pixeli;
    progres               = params.progresImagine;
    
end

