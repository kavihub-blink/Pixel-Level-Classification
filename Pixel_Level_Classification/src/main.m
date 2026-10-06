%% IA-2 Pixel-Level Classification
% Road Scene Understanding
% Classes: Road, Vehicle, Building, Vegetation

clear;
clc;
close all;

%% Step 1: Load Input Image

imagePath = fullfile('..', 'input', 'road_image.png');

img = imread('D:\Pixel_Level_Classification\input\road_image.png');

disp("Image loaded successfully.");

%% Step 2: Resize Image

img = imresize(img, 0.5);

disp("Image resized successfully.");

%% Step 3: Display Original and Resized Image

figure;

subplot(1,2,1);
imshow(imread('D:\Pixel_Level_Classification\input\road_image.png'));
title('Original Image');

subplot(1,2,2);
imshow(img);
title('Resized Image');

%% Step 4: Display Image Size

imageSize = size(img);

disp("Resized image size:");
disp(imageSize);
%% Step 5: Extract RGB + HSV Pixel Features

% Extract RGB channels
R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);

% Convert RGB image to HSV
hsvImg = rgb2hsv(img);

% Extract HSV channels
H = hsvImg(:,:,1);
S = hsvImg(:,:,2);
V = hsvImg(:,:,3);

% Create combined feature matrix
features = double([
    R(:), ...
    G(:), ...
    B(:), ...
    H(:), ...
    S(:), ...
    V(:)
    ]);

disp("RGB + HSV pixel features extracted successfully.");

disp("Feature matrix size:");
disp(size(features));
%% Step 7: Create Training Masks

figure;
imshow(img);
title('Select Training Regions');

disp("Select ROAD region and double-click to finish.");
roadMask = roipoly;

disp("Select VEHICLE region and double-click to finish.");
vehicleMask = roipoly;

disp("Select BUILDING region and double-click to finish.");
buildingMask = roipoly;

disp("Select VEGETATION region and double-click to finish.");
vegetationMask = roipoly;

disp("Select SKY region and double-click to finish.");
skyMask = roipoly;
%% Step 8: Create Training Labels

% Convert masks into column vectors
roadPixels = roadMask(:);
vehiclePixels = vehicleMask(:);
buildingPixels = buildingMask(:);
vegetationPixels = vegetationMask(:);
skyPixels = skyMask(:);

% Create label vector
labels = zeros(size(roadPixels));

% Assign class numbers
labels(roadPixels) = 1;          % Road
labels(vehiclePixels) = 2;       % Vehicle
labels(buildingPixels) = 3;      % Building
labels(vegetationPixels) = 4;    % Vegetation
labels(skyPixels) = 5;           % Sky

% Select only labeled pixels
selectedPixels = labels > 0;

% Create training data
trainingFeatures = features(selectedPixels, :);
trainingLabels = labels(selectedPixels);

disp("Training data created successfully.");

disp("Training feature matrix size:");
disp(size(trainingFeatures));

disp("Number of training samples:");
disp(length(trainingLabels));


%% Step 8.1: Limit Training Samples

maxSamplesPerClass = 2000;

selectedTrainingFeatures = [];
selectedTrainingLabels = [];

for classID = 1:5

    % Find pixels belonging to current class
    classIndex = find(trainingLabels == classID);

    % Limit samples if there are more than 2000
    if length(classIndex) > maxSamplesPerClass

        classIndex = classIndex( ...
            randperm(length(classIndex), maxSamplesPerClass));

    end

    % Add selected samples
    selectedTrainingFeatures = [
        selectedTrainingFeatures;
        trainingFeatures(classIndex, :)
        ];

    selectedTrainingLabels = [
        selectedTrainingLabels;
        trainingLabels(classIndex)
        ];

end

% Replace original training data with reduced data
trainingFeatures = selectedTrainingFeatures;
trainingLabels = selectedTrainingLabels;

disp("Training samples reduced for faster KNN training.");

disp("Final training feature matrix size:");
disp(size(trainingFeatures));

disp("Final number of training samples:");
disp(length(trainingLabels));
%% Step 8.2: Validation Evaluation

% Split labeled samples into training and validation sets
cv = cvpartition(trainingLabels, 'HoldOut', 0.20);

trainIndex = training(cv);
validationIndex = test(cv);

XTrain = trainingFeatures(trainIndex, :);
YTrain = trainingLabels(trainIndex);

XValidation = trainingFeatures(validationIndex, :);
YValidation = trainingLabels(validationIndex);

% Train KNN using 80% of the samples
validationClassifier = fitcknn(XTrain, YTrain, ...
    'NumNeighbors', 5, ...
    'Standardize', true);

% Predict validation samples
validationPredictions = predict(validationClassifier, XValidation);

% Calculate validation accuracy
validationAccuracy = mean(validationPredictions == YValidation) * 100;

disp("Validation accuracy:");
disp(validationAccuracy);

% Display confusion matrix
figure;
confusionchart(YValidation, validationPredictions);

title('KNN Validation Confusion Matrix');
%% Step 9: Train KNN Pixel Classifier

pixelClassifier = fitcknn(trainingFeatures, trainingLabels, ...
    'NumNeighbors', 5, ...
    'Standardize', true);

disp("KNN pixel classifier trained successfully.");
%% Step 10: Predict Class for Every Pixel

predictedLabels = predict(pixelClassifier, features);

disp("Pixel-wise prediction completed.");

disp("Number of predicted pixels:");
disp(length(predictedLabels));
%% Step 11: Create Prediction Map

predictionMap = reshape(predictedLabels, size(R));

disp("Prediction map created successfully.");

disp("Prediction map size:");
disp(size(predictionMap));
%% Step 12: Visualize Prediction Map

figure;

imagesc(predictionMap);
axis image;
axis off;

title('Pixel-wise Classification Map');

colormap([
    0.5 0.5 0.5;   % Road
    1.0 0.0 0.0;   % Vehicle
    0.0 0.0 1.0;   % Building
    0.0 0.7 0.0    % Vegetation
    0.4 0.8 1.0    % Sky - Light Blue
]);

colorbar;

caxis([1 5]);

cb = colorbar;
cb.Ticks = 1:5;
cb.TickLabels = {'Road', 'Vehicle', 'Building', 'Vegetation','Sky'};