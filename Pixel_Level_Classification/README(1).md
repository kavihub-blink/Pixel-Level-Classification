# Pixel-Level Classification for Road Scene Understanding

## 1. Project Overview

This project develops a simplified pixel-level classification system for road-scene understanding using MATLAB. Each pixel in a road image is classified into one of five classes:

1. Road
2. Vehicle
3. Building
4. Vegetation
5. Sky

The system uses RGB and HSV pixel features and a K-Nearest Neighbors (KNN) classifier to generate a pixel-wise prediction map.

## 2. Problem Statement

Road-scene images contain different regions such as roads, vehicles, buildings, vegetation, and sky. A computer vision system needs to distinguish these regions at pixel level to support scene understanding.

The objective is to develop a simple and explainable pixel-level classification system in MATLAB and visualize the predicted class of every pixel.

## 3. Objective

- Load and preprocess a road-scene image.
- Extract RGB and HSV features from individual pixels.
- Create training labels using manually selected image regions.
- Train a KNN classifier.
- Predict the class of every image pixel.
- Generate and visualize a pixel-wise classification map.
- Evaluate the classifier using a held-out validation set.

## 4. Classes

| Label | Class | Display Color |
|---:|---|---|
| 1 | Road | Gray |
| 2 | Vehicle | Red |
| 3 | Building | Orange |
| 4 | Vegetation | Green |
| 5 | Sky | Light Blue |

## 5. Methodology

```text
Input Road Image
       ↓
Image Resizing
       ↓
RGB Feature Extraction
       ↓
HSV Conversion
       ↓
RGB + HSV Feature Matrix
       ↓
Manual ROI Selection
       ↓
Pixel Labels
       ↓
Training Sample Selection
       ↓
KNN Classification
       ↓
Pixel-wise Prediction
       ↓
Prediction Map
       ↓
Visualization and Evaluation
```

## 6. Features Used

Each pixel is represented using six features:

- Red (R)
- Green (G)
- Blue (B)
- Hue (H)
- Saturation (S)
- Value (V)

The final feature vector is:

```text
[R, G, B, H, S, V]
```

The RGB values are converted to `double` before classification so that MATLAB can perform standardization correctly.

## 7. Machine Learning Model

### K-Nearest Neighbors (KNN)

The project uses KNN with:

- Number of neighbors: `K = 5`
- Standardization: Enabled
- Maximum training samples per class: 2,000

With five classes, the system can use up to 10,000 training samples.

## 8. Tools and Technologies

- MATLAB R2026a
- MATLAB Statistics and Machine Learning Toolbox
- MATLAB Image Processing Toolbox
- K-Nearest Neighbors (KNN)
- RGB and HSV image features
- Git and GitHub

## 9. Project Structure

```text
Pixel_Level_Classification/
│
├── input/
│   └── road_image.png
│
├── output/
│   └── prediction_map.png
│
├── src/
│   └── main.m
│
├── training/
│
├── README.md
│
└── .gitignore
```

## 10. How to Run

1. Open MATLAB.
2. Open the project folder:
   `D:\Pixel_Level_Classification`
3. Open:
   `src/main.m`
4. Run `main.m`.
5. Select the following regions when MATLAB asks:
   - Road
   - Vehicle
   - Building
   - Vegetation
   - Sky
6. The KNN classifier is trained.
7. The classifier predicts the class of every pixel.
8. The pixel-wise classification map is displayed.

## 11. Evaluation

A simple hold-out validation method is used to evaluate the KNN classifier.

The selected labeled samples are divided into:

- 80% training data
- 20% validation data

The following metrics can be reported:

### Validation Accuracy

```text
Accuracy = Correct Predictions / Total Validation Samples × 100
```

### Confusion Matrix

A confusion matrix is generated to observe how well each class is distinguished from the others.

The evaluation is performed on manually selected labeled pixels and therefore represents performance on the selected sample regions, not a benchmark semantic-segmentation accuracy.

## 12. Results

The system successfully generates a pixel-wise classification map for the road scene.

The final visualization separates:

- Sky from buildings using an additional Sky class.
- Vegetation regions using green.
- Vehicle regions using red.
- Road regions using gray.
- Building regions using orange.

Because the current model uses pixel-level color features and KNN, visually similar regions can still be confused. For example, road and dark vehicle pixels may have similar RGB/HSV values.

## 13. Analysis

### Strengths

- Simple and easy to understand.
- Uses explainable pixel-level features.
- Works without a deep neural network.
- Demonstrates the complete machine-learning classification pipeline.
- Provides a visual prediction map.

### Limitations

- Classification depends strongly on the manually selected training regions.
- RGB/HSV features do not contain detailed shape or object information.
- Similar-colored road and vehicle pixels can be confused.
- The model is not a full semantic segmentation network such as U-Net.
- Validation accuracy depends on the selected ROI samples.

### Future Improvements

- Add texture features.
- Add spatial features.
- Use a larger and more diverse labeled dataset.
- Compare KNN with Decision Tree or SVM.
- Develop a CNN/U-Net based semantic segmentation model.
- Evaluate using an independent ground-truth dataset.

## 14. Conclusion

A simplified pixel-level road-scene classification system was developed using MATLAB. RGB and HSV pixel features were extracted and classified using a KNN model. Manual region selection was used to create labeled training data, and the trained classifier generated a pixel-wise prediction map.

The project demonstrates the complete workflow from image preprocessing and feature extraction to machine learning classification, evaluation, and visualization.

## 15. References

1. MATLAB Documentation — Image Processing Toolbox.
2. MATLAB Documentation — Statistics and Machine Learning Toolbox.
3. MATLAB Documentation — `fitcknn`.
4. MATLAB Documentation — `rgb2hsv`.
5. MATLAB Documentation — `roipoly`.

## 16. GitHub Repository

GitHub Repository:

**[Add your GitHub repository link here]**

Example:

```text
https://github.com/your-username/Pixel_Level_Classification
```
