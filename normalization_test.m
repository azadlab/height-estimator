% challenging example Images :
% seq 4 -- img 32,150
% seq 2 -- img 

close all; 
clear all;

ratio = 0.25;

I1 = imresize(rgb2ycbcr(imread('F:\burglary project\sequences\4\resized\0001.jpg')),ratio);
I2 = imresize(rgb2ycbcr(imread('F:\burglary project\sequences\4\resized\0150.jpg')),ratio);

im1 = I1(:,:,1);
im2 = I2(:,:,1);

% im1 = imresize(im1,ratio);
% im2 = imresize(im2,ratio);


% im1 = histeq(im1);
% im2 = histeq(im2);

figure;

%% DCT Normalization

DCTImg1=DCT_normalization(im1,10);
DCTImg2=DCT_normalization(im2,10);
diffDCT = double(abs(DCTImg1-DCTImg2))/256;
th = graythresh(diffDCT);
subplot(4,5,1);imshow(diffDCT>th),title('Discrete Cosine Transform');


%% MSR Normalization

MSRImg1=multi_scale_retinex(im1,[5 10 25]);
MSRImg2=multi_scale_retinex(im2,[5 10 25]);
diffMSR = double(abs(MSRImg1-MSRImg2))/256;
th = graythresh(diffMSR);
subplot(4,5,2);imshow(diffDCT>th),title('Multi Scale Retinex');


%% ASR Normalization

ASRImg1=adaptive_single_scale_retinex(im1,15);
ASRImg2=adaptive_single_scale_retinex(im2,15);
diffASR = double(abs(ASRImg1-ASRImg2))/256;
th = graythresh(diffASR);
subplot(4,5,3);imshow(diffASR>th),title('Adaptive Single Retinex');

%% homomorphic Normalization

HMImg1=normalize8(homomorphic(im1,3, .5, 3));
HMImg2=normalize8(homomorphic(im2,3, .5, 3));
I1(:,:,1) = HMImg1;
I2(:,:,1) = HMImg2;
diffCHM = abs(I1-I2);
diffHM = double(rgb2gray(diffCHM))/256;
th = graythresh(diffHM);
subplot(4,5,4);imshow(diffHM>th),title('Homomorphic');

%% SSQ Normalization

SSQImg1=single_scale_self_quotient_image(im1,7, 1);
SSQImg2=single_scale_self_quotient_image(im2,7, 1);
diffSSQ = double(abs(SSQImg1-SSQImg2))/256;
th = graythresh(diffSSQ);
subplot(4,5,5);imshow(diffSSQ>th),title('Single Scale Quotient');



%% MSQ Normalization

MSQImg1=multi_scale_self_quotient_image(im1,[3 5 11 15],[1 1.1 1.2 1.3]);
MSQImg2=multi_scale_self_quotient_image(im2,[3 5 11 15],[1 1.1 1.2 1.3]);
diffMSQ = double(abs(MSQImg1-MSQImg2))/256;
th = graythresh(diffMSQ);
subplot(4,5,6);imshow(diffMSQ>th),title('Multi scale Quotient');

%% WA Normalization

WAImg1=wavelet_normalization(im1,0.4, 'db1');
WAImg2=wavelet_normalization(im2,0.4, 'db1');
diffWA = double(abs(WAImg1-WAImg2))/256;
th = graythresh(diffWA);
subplot(4,5,7);imshow(diffWA>th),title('Wavelet Normalization');


%% WD Normalization

WDImg1=wavelet_denoising(im1,'haar');
WDImg2=wavelet_denoising(im2,'haar');
diffWD = double(abs(WDImg1-WDImg2))/256;
th = graythresh(diffWD);
subplot(4,5,8);imshow(diffWD>th),title('Wavelet Diffusion');


%% ISD Normalization

% ISDImg1=isotropic_smoothing(im1);
% ISDImg2=isotropic_smoothing(im2);
% diffISD = double(abs(ISDImg1-ISDImg2))/256;
% th = graythresh(diffISD);
diffISD = zeros(size(im1));
subplot(4,5,9);imshow(diffISD>th),title('Isotropic Diffusion');

%% ASD Normalization

% ASDImg1=anisotropic_smoothing(im1);
% ASDImg2=anisotropic_smoothing(im2);
% diffASD = double(abs(ASDImg1-ASDImg2))/256;
% th = graythresh(diffASD);
% subplot(4,5,10);imshow(diffASD>th),title('Anisotropic Diffusion');


%% SG Normalization

SGImg1=steerable_gaussians(im1,[0.5,1],6);
SGImg2=steerable_gaussians(im2,[0.5,1],6);
diffSG = double(abs(SGImg1-SGImg2))/256;
th = graythresh(diffSG);
subplot(4,5,11);imshow(diffSG>th),title('Steerable Gaussians');

%% NL Normalization

NLImg1=nl_means_normalization(im1,80,3);
NLImg2=nl_means_normalization(im2,80,3);
diffNL = double(abs(NLImg1-NLImg2))/256;
th = graythresh(diffNL);
subplot(4,5,12);imshow(diffNL>th),title('Non-local Means');


%% ANL Normalization

ANLImg1=adaptive_nl_means_normalization(im1);
ANLImg2=adaptive_nl_means_normalization(im2);
diffANL = double(abs(ANLImg1-ANLImg2))/256;
th = graythresh(diffANL);
subplot(4,5,13);imshow(diffANL>th),title('Adaptive Non-local Means');

%% MSD Normalization

% MSDImg1=anisotropic_smoothing_stable(im1);
% MSDImg2=anisotropic_smoothing(im2);
% diffMSD = double(abs(MSDImg1-MSDImg2))/256;
% th = graythresh(diffMSD);
% subplot(4,5,14);imshow(diffMSD>th),title('Modified Anisotropic Diffusion');

%% GD Normalization

GDImg1=gradientfaces(im1);
GDImg2=gradientfaces(im2);
diffGD = double(abs(GDImg1-GDImg2))/256;
th = graythresh(diffGD);
subplot(4,5,15);imshow(diffGD>th),title('Gradient Faces');

%% WF Normalization

WFImg1=weberfaces(im1);
WFImg2=weberfaces(im2);
diffWF = double(abs(WFImg1-WFImg2))/256;
th = graythresh(diffWF);
subplot(4,5,16);imshow(diffWF>th),title('Weber Faces');


%% MSW Normalization

MSWImg1=multi_scale_weberfaces(im1);
MSWImg2=multi_scale_weberfaces(im2);
diffMSW = double(abs(MSWImg1-MSWImg2))/256;
th = graythresh(diffMSW);
subplot(4,5,17);imshow(diffMSW>th),title('Multi-scale Weber Faces');

%% LSSF Normalization

LSSFImg1=lssf_norm(im1);
LSSFImg2=lssf_norm(im2);
diffLSSF = double(abs(LSSFImg1-LSSFImg2))/256;
th = graythresh(diffLSSF);
subplot(4,5,18);imshow(diffLSSF>th),title('Large-scale small-scale');


%% TansTriggs Normalization

TTImg1=tantriggs(im1);
TTImg2=tantriggs(im2);
diffTT = double(abs(TTImg1-TTImg2))/256;
th = graythresh(diffTT);
subplot(4,5,19);imshow(diffTT>th),title('Tan Triggs');


%% DoG Normalization

DoGImg1=dog(log(double(im1+1)),2,3);
DoGImg2=dog(log(double(im2+1)),2,3);
diffDoG = double(abs(DoGImg1-DoGImg2))/256;
th = graythresh(diffDoG);
subplot(4,5,20);imshow(diffDoG>th),title('DoG');
