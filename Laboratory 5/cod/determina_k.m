idx_CMAV = find(scoruriCMAV>0.9);
idx_SVM = find(scoruriSVM>0.9);

figure;
histogram(k_uri(idx_CMAV),120);

figure;
histogram(k_uri(idx_SVM),120)