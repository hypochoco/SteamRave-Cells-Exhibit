# SteamRave-Cells-Exhibit

Projection art with the v1 Kinect Sensor (Xbox 1414)

## Goal

We want to output a row of panels with changing colors. Something like the following

![goal](https://user-images.githubusercontent.com/84194796/155063054-f6c4c3b6-186c-4a4c-b855-321a964139c3.png)

The three rows are three different ideas that we have. The left side will rotate through colors from one end of the spectrum, and the right side will rotate colors fromt the other end of the spectrum. At some point in the middle, they will meet in the middle and match colors, and then continue the color changing cycle.

We want to use the Kinect sensor to find the distance of the viewer. Then, we want to change the size of the inner panels based on how far the viewer (farther = smaller, closer = bigger). Later, we want to experiment changed focus based on the distance, possibly saturation/color (farther = blurrier, closer = clearer).

## Exhibit

The actual exhibit will project this image onto panels arranged in a jutting arrangement so that only one side of the panels will be viewable from the side. The Kinect sensor will measure how far the viewer is from the exhibit.

![6](https://user-images.githubusercontent.com/84194796/155063965-cc14f2b0-dc16-4969-b82b-4b62791669eb.jpg)

In the picture above, two projectors were used, but we will only use one projector. We can adjust the shape projection images to match the panels by using the Keystone library (see below).

## Notes

- Daniel and I are using Windows. So far (2/21) all of the files are for Windows. Mac uses a different library, see below.
- For Mac, Daniel Shiffman has a good library with good documentation on his [website](https://shiffman.net/p5/kinect/)

## How to Run

- Ensure you have the necessary drivers and libraries.
- To run the program, you can just clone (or download the file) anywhere on your computer and double-click to run it. The processing application folder does not need to be in the same folder.
- Run the sketch in Processing.
- You can use the Keystone library to adjust the shape and number of panels. For example, in kinectKeyston, press 'c' to enter transformation mode.

## Installing Kinect Software (Windows)

To use the Kinect sensor, install the following from Microsoft.

- [Kinect for Windows Developer Toolkit v1.8](https://www.microsoft.com/en-us/download/confirmation.aspx?id=40276)
- [Kinect for Windows SDK 1.8](https://www.microsoft.com/en-us/download/confirmation.aspx?id=40278)


## Using Processing

NOTE: Processing 4.0 beta 6 is sus! Windows detects security issues with it, so we are just sticking with 3.5.4 for now.

[Install Processing 3.5.4](https://processing.org/download)

Unzip the download into a folder you want to work in. In the folder, open the processing application.

## Installing Necessary Libraries in Processing

Open the processing application and go to the top where it says "Sketch". Next, go to "Import Library" -> "Add Library". In the search bar, search for the following libraries and install them.

- **Kinect4WinSDK** by Bryan Chung (Windows) - library for use with Kinect
- **Open Kinect for Processing** by Daniel Shiffman (Mac) - library for use with Kinect
- **Keystone** by David Bouchard - library to map projections [guide](https://fh-potsdam.github.io/doing-projection-mapping/processing-keystone/)

## Future Ideas
- saturation or the shape changes depending on the number of people in the plain



