# TalkHands

TalkHands is an AI-powered sign language detection and translation application designed to bridge the communication gap between sign language users and others. This project leverages YOLO-based gesture detection for accurate and efficient recognition of sign language gestures.

## Features

- Real-time sign language detection using the camera.
- Gesture recognition powered by YOLO (You Only Look Once).
- Converts detected gestures into text for seamless communication.
- Simple and intuitive user interface.

## Installation

Follow these steps to set up and run the project:

### Prerequisites

- Python 3.7 or later
- Flutter SDK
- Required Python libraries (listed in `requirements.txt`)
- Git

### Steps

1. Clone the main repository:
   ```bash
   git clone https://github.com/stulumenn/TalkHands
2. Clone the YOLO gesture detection repository:
   ```bash
    git clone https://github.com/RumiaGIT/yolo-gesture-detection
3. Move the requirements.txt file:
   mv yolo-gesture-detection/yolov5/requirements.txt yolo-gesture-detection/
4. Find your IP address:
- For Windows: Run ipconfig in the terminal.
- For macOS/Linux: Run ifconfig in the terminal.
5. Update the Flutter app configuration:
- Navigate to lib/features/screens/camera_page.dart.
- Locate the line containing your_ip_address and replace it with your actual IP address.
6. Start the Flask server:
   ```bash
    python app.py
7. Start the Flutter application on your device:
   ```bash
    flutter run

Usage
1. Open the app on your device.
2. Login or create account
3. On the home page click on the button
4. Point at the picture and click on the button on bottom. App will take a picture and write down the result
