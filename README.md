# iOS Image Temperature Adjustment App

## 📌 Overview
This iOS application allows users to adjust the color temperature of a JPEG image using **SwiftUI** and **OpenCV**. The app applies a temperature adjustment to shift color tones towards a warmer (reddish) or cooler (bluish) hue while preserving overall image quality.

## 🚀 Features
- Load a JPEG image from the device.
- Adjust the color temperature using a slider.
- Save the modified image as a JPEG.
- User-friendly UI built with SwiftUI.
- Efficient image processing using OpenCV.

## 🛠️ Technologies Used
- **SwiftUI** for the User Interface.
- **OpenCV** for image processing (via Swift bridging).
- **Xcode** as the development environment.

## 🔧 Installation
### Prerequisites
- macOS with **Xcode** installed.
- **OpenCV2.framework** downloaded from [OpenCV GitHub](https://github.com/opencv/opencv)

### Steps
1. Clone this repository:
   ```sh
   git clone https://github.com/amini28/SwiftUI-OpenCV.git
   ```
2. Download **OpenCV2.framework** from the [OpenCV official GitHub](https://github.com/opencv/opencv/releases).
3. Extract and copy **OpenCV2.framework** into your Xcode project's `Frameworks` folder.
4. Open Xcode and go to **Project Settings > General > Frameworks, Libraries, and Embedded Content**.
5. Click the `+` button, then select **OpenCV2.framework**.
6. Open the `SwiftUI-OpenCV.xcodeproj` file in Xcode:
7. Build and run the app on a device.

## 📸 Usage
1. **Select an image**: Load a JPEG image from the file system.
2. **Adjust the temperature**: Move the slider to increase or decrease temperature.
   - Positive values → Warmer (reddish tones)
   - Negative values → Cooler (bluish tones)
3. **Save the image**: The adjusted image is saved as a new JPEG file.

## 📑 Code Structure
- `ImageProcessingView.swift` – SwiftUI view for user interaction.
- `OpenCVWrapper.h/.mm` – Bridging code to call OpenCV functions.
- `ImageProcessingViewModel.swift` – Core logic for applying temperature adjustments using OpenCV.
- `SwiftUI-OpenCV-Bridging-Header.h` – Header file to enable Swift and Objective-C interoperability for OpenCV.
