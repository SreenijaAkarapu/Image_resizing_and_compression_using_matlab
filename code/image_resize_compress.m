clc;
clear;

% Step 1: Select an image
[filename, filepath] = uigetfile({'*.jpg;*.png;*.bmp;*.tiff', ...
    'Image Files (*.jpg, *.png, *.bmp, *.tiff)'});

if isequal(filename, 0)
    disp('User canceled the operation');
    return;
end

imagePath = fullfile(filepath, filename);

% Step 2: Read original image
originalImg = imread(imagePath);

% Step 3: Get desired quality percentage
qualityPercentage = input('Enter the desired quality level (1–100): ');

if qualityPercentage < 1 || qualityPercentage > 100
    disp('Please enter a valid quality percentage between 1 and 100.');
    return;
end

% Step 4: Resize image while preserving aspect ratio
newSize = round(size(originalImg, 1:2) * (qualityPercentage / 100));
resizedImg = imresize(originalImg, newSize);

% Step 5: Save resized image
[~, name, ext] = fileparts(filename);
newFilename = fullfile(filepath, ...
    [name, '_resized_', num2str(qualityPercentage), ext]);

imwrite(resizedImg, newFilename);

disp(['Resized image saved at ', newFilename]);

% Step 6: Display comparison
figure;
sgtitle('Image Comparison: Original vs Resized');

subplot(1,2,1);
imshow(originalImg);
title('Original Image');

subplot(1,2,2);
imshow(resizedImg);
title(['Resized Image (', num2str(qualityPercentage), '%)']);
