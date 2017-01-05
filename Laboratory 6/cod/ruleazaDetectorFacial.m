function [detectii, scoruriDetectii, imageIdx] = ruleazaDetectorFacial(parametri)
    % 'detectii' = matrice Nx4, unde 
    %           N este numarul de detectii  
    %           detectii(i,:) = [x_min, y_min, x_max, y_max]
    % 'scoruriDetectii' = matrice Nx1. scoruriDetectii(i) este scorul detectiei i
    % 'imageIdx' = tablou de celule Nx1. imageIdx{i} este imaginea in care apare detectia i
    %               (nu punem intregul path, ci doar numele imaginii: 'albert.jpg')

    % Aceasta functie returneaza toate detectiile ( = ferestre) pentru toate imaginile din parametri.numeDirectorExempleTest
    % Directorul cu numele parametri.numeDirectorExempleTest contine imagini ce
    % pot sau nu contine fete. Aceasta functie ar trebui sa detecteze fete atat pe setul de
    % date MIT+CMU dar si pentru alte imagini (imaginile realizate cu voi la curs+laborator).
    % Functia 'suprimeazaNonMaximele' suprimeaza detectii care se suprapun (protocolul de evaluare considera o detectie duplicata ca fiind falsa)
    % Suprimarea non-maximelor se realizeaza pe pentru fiecare imagine.

    % Functia voastra ar trebui sa calculeze pentru fiecare imagine
    % descriptorul HOG asociat. Apoi glisati o fereastra de dimeniune paremtri.dimensiuneFereastra x  paremtri.dimensiuneFereastra (implicit 36x36)
    % si folositi clasificatorul liniar (w,b) invatat poentru a obtine un scor. Daca acest scor este deasupra unui prag (threshold) pastrati detectia
    % iar apoi mporcesati toate detectiile prin suprimarea non maximelor.
    % pentru detectarea fetelor de diverse marimi folosit un detector multiscale

    imgFiles = dir( fullfile( parametri.numeDirectorExempleTest, '*.jpg' ));
    %initializare variabile de returnat
    detectii = zeros(0,4);
    scoruriDetectii = zeros(0,1);
    imageIdx = cell(0,1);

    for i = 1:length(imgFiles)      
        fprintf('Rulam detectorul facial pe imaginea %s\n', imgFiles(i).name)
        img = imread(fullfile( parametri.numeDirectorExempleTest, imgFiles(i).name ));    
        if(size(img,3) > 1)
            img = rgb2gray(img);
        end    
        
        %completati codul functiei in continuare

%         img = imresize(img,[491 664]);
        imgOriginala = img;
        marimeInitiala = size(img);
        for scale = 1.1:0.1:1.1
        size(img);
        img = imresize(img,scale);
        descriptorHOGImagine = vl_hog(single(img),parametri.dimensiuneCelulaHOG);
        step = round(parametri.dimensiuneFereastra/parametri.dimensiuneCelulaHOG);
        dimCelula = parametri.dimensiuneCelulaHOG;
        detectiiCurente = zeros(0,4);
        scoruriDetectiiCurente = zeros(0,1);
        imageIdxCurente = cell(0,1);
        dim = parametri.dimensiuneFereastra;
        for j = 1:size(descriptorHOGImagine,1)-step
            for k = 1:size(descriptorHOGImagine,2)-step
                descriptorHOGCurent = descriptorHOGImagine(j:j-1+step,k:k-1+step,:);
                result = descriptorHOGCurent(:)'*parametri.w+parametri.b;
                if result > parametri.threshold
                    rezultat_clasificare = result;
                    marimeActuala = size(img);
                    raport_x = (marimeInitiala(2)/marimeActuala(2))
                    raport_y = (marimeInitiala(1)/marimeActuala(1))
                    j
                    k
                    detectiiCurente = [detectiiCurente; ceil(((k-1)*dimCelula+1)*raport_x) ceil(((j-1)*dimCelula+1)*raport_y) ceil(((k-1)*dimCelula+dim)*raport_x) ceil(((j-1)*dimCelula+dim)*raport_y)];
                    scoruriDetectiiCurente = [scoruriDetectiiCurente rezultat_clasificare];
                    imageIdxCurente = [imageIdxCurente imgFiles(i).name];
                end
            end
        end
        rezultate = [];
        if(size(detectiiCurente,1) > 0)
            rezultate = eliminaNonMaximele(detectiiCurente,scoruriDetectiiCurente,size(imgOriginala));
        end
        
%         for x = 1:size(rezultate,2)
%             if rezultate(x) == 1
%                 detectii = [detectii; detectiiCurente(x,:)];
%                 scoruriDetectii = [scoruriDetectii; scoruriDetectiiCurente(x,:)];
%                 imageIdx = [imageIdx; imgFiles(i).name];
%             end
%         end
        detectii = [detectii; detectiiCurente(rezultate,:)];
        scoruriDetectii = [scoruriDetectii scoruriDetectiiCurente(rezultate)];
        imageIdx = [imageIdx imageIdxCurente(rezultate)];
        detectiiCurente;
        
        end
    end
    
end




