<img width="405" alt="Frame 2" src="https://user-images.githubusercontent.com/61394624/157555498-c7750d91-586f-40cc-9635-90f7361bc3da.png">

## Getting Started 
Welcome to the BUDI repository! In order to get the project up and running on your system, follow these steps: 

_Environment Setup_
  1) Install XCode, and ensure that you have at least version 13.2.1  
  2) Clone the "main-app" repository into the desired directory on your device. 
  3) In your terminal, navigate to the project directory. Within the project directory, go to CardinalKit > CardinalKit-Example 
  4) Once you're in CardinalKit-Example, run "pod install" to get the CocoaPods setup. 

_Build & Run_
  1) Open the workspace by navigating to your project directory, then opening the "CardinalKit.xcworkspace" file within CardinalKit > CardinalKit-Example
  2) Install a simulator with an Apple Watch and iPhone through XCode. 
  3) Clean the build folder in XCode: Product > Clean Build Folder 
  4) Run the project by building & running the "Budi Watchkit" on iOS simulators: Apple Watch Series 4+ 


## Dependencies 
- CardinalKit 
- ResearchKit
- HealthKit
- CocoaPods 

## Troubleshooting 

If you're having trouble getting started with the codebase or with the latest repo pull, consider taking the following steps:

1. quit XCode completely 
2. remove CocoaPods: in the terminal, go to the CardinalKit-Example folder and run the command "pod deintegrate"
3. reinstall CocoaPods: in the same folder, run the command "pod install"
4. reopen CardinalKit.xcworkspace in XCode
5. clean build folder: Product > Clean Build Folder 
6. rebuild & run 



## Highlights of the Codebase

### Collecting and Sending Data from the Watch
Acceleration data is collected on the Apple watch and sent to the phone via a shared WatchConnectivity session. The files where the phone and watch directly communicate through WCSessions are CardinalKit-Example > Library > WatchViewModel and BUDI WatchKit Extension > SendDataToPhone. The actual acceleration data is collected in CoreMotionManager via DeviceMotion, which gives gravity adjusted rather than raw acceleration. Every five seconds, the maximum observed acceleration value is sent to the phone as a message in the WCSession. 

### Playing Games 
Two ResearchKit active tasks currently comprise the "Games" section of the application. To edit these files & add more games, go to the CardinalKit > Components > Home > Games. Note, you cannot edit the ResearchKit tasks themselves; these are off the shelf from Apple. 

### Viewing Progress
Users can currently view their progress on their daily therapy rings and their total therapy for the week in the "View Progress" section. Progress data relies on the goals the users set for active tasks & gross motor therapy (live therapy), which they set in their profile (as described below). In order to populate this view, we pull in data from Google's Firebase Firestore for the last seven days. The essential files involved are: WatchViewModel (sends the therapy duration data to Firestore, updating the totaltime in seconds for a given date after a session has been completed), ProgressUIChartView (houses ProgressUIChartViewModel which fetches the data from last 7 days from Firestore; populates the weekly chart), TherapyRingView (creates therapy ring based on percentage of therapy goal achieved on a given day), and ProgressUIView (presents the chart and rings to user). 

### Profile: Survey, Goal Setting, Therapy Schedule 
In the profile view, the user can provide information about themselves, modify therapy schedule and notifications, set daily therapy goals and view contact information.

Goal Setting: Allows the user to set daily goals for number of active tasks and minutes of physical therapy. These variables are persistant and accessible globaly.


## Contact 

For general questions about the Budi project, reach out to blynns@stanford.edu. 

_Budi watchOS & data collection inquiries_: 
    
    Taylor Lallas -- tlallas@stanford.edu
    
    Tracy Cai -- cpcai@stanford.edu
    
    
_Live Therapy View_:
    
    Blynn Shideler -- blynns@stanford.edu
    
    Lavender Chen -- lvc0417@stanford.edu
    
    Taylor Lallas -- tlallas@stanford.edu
    

_iOS Charts & Progress View_:

    Lina Fang -- linafang@stanford.edu
    
    Yoonju Kim -- yoonjuk@stanford.edu
    
    Lavender Chen -- lvc0417@stanford.edu
    
    Taylor Lallas -- tlallas@stanford.edu
    

_Goal Setting_:
  
    Beste Aydin -- bestea@stanford.edu
  
    
_Budi Integration with Firebase_: 

    Bill Zhu -- zheqzhu@stanford.edu
    
    Taylor Lallas -- tlallas@stanford.edu
 





