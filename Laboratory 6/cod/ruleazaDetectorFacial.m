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

        img = imresize(img,[491 664]);
        descriptorHOGImagine = vl_hog(single(img),parametri.dimensiuneFereastra);
        step = round(parametri.dimensiuneFereastra/parametri.dimensiuneCelulaHOG);

        for j = 1:size(descriptorHOGImagine,1)-step
            for k = 1:size(descriptorHOGImagine,2)-step
                descriptorHOGCurent = descriptorHOGImagine(j:j-1+step,k:k-1+step,:);
                result = descriptorHOGCurent(:)'*parametri.w+parametri.b;
                if result > parametri.threshold
                    rezultat_clasificare = result
  
                end
            end
        end   
    end
    
end




