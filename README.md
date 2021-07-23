# HikerNet

## About

HikerNet is a mobile app that allows you to record, view, and analyze cellular connectivity while hiking or walking. The app is part of a research project at Georgia Tech focused on exploring internet access in rural areas and investigating new ways to measure cellular connectivity. You can learn more about the project and get involved [here](https://hikernet.rnoc.gatech.edu).

## How it works

HikerNet is pretty simple. When you're ready to go on a hike, you open the app, tap *Start*, and begin walking. While you move, the app takes a measurement every 30 seconds to see if there is an internet connection. When you finish your hike, you simply open the app, tap *Stop*, and your data saves and uploads to the HikerNet servers. If you don't have an internet connection when you stop your Hike, the data saves locally on device and is automatically uploaded later.

| Record | View | Analyze |
| :---: | :---: | :---: |
| ![HikerNet Record Screenshot][record-screenshot] | ![HikerNet Hikes Screenshot][hikes-screenshot] | ![HikerNet Detail Screenshot][detail-screenshot] |

## Built with

* [Swift](https://swift.org)
* [SwiftUI](https://developer.apple.com/documentation/swiftui)
* [Core Location](https://developer.apple.com/documentation/corelocation)
* [Core Data](https://developer.apple.com/documentation/coredata)
* [Core Telephony](https://developer.apple.com/documentation/coretelephony)
* [Network](https://developer.apple.com/documentation/network)
* [Mapbox](https://www.mapbox.com)
* [Lottie](https://airbnb.design/lottie/)

[record-screenshot]: Images/hikernet-record-ss.png
[hikes-screenshot]: Images/hikernet-hikes-ss.png
[detail-screenshot]: Images/hikernet-detail-ss.png
