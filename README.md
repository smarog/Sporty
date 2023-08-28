# Sporty
Sporty is an upcoming sports event viewer app.

## Installation Instructions
1. Clone the repository.
2. From Terminal navigate to the project folder.
3. At the Terminal run the command "pod install" in order to install the projects pods.
4. Open the Sporty.xcworkspace file on Xcode
5. Build and Run the project.

## Project Architecture
 The architecture I used for this project is MVVM. The main reason I decided to use this architecture is because I wanted to have small view controllers without business logic in them  that would end up to cleaner code. Also this architecture is well suited for small scale projects like this one.  

Since I have used the MVC architecture before I have seen and experienced many of its drawbacks such as very large controllers that contain both UI and bussness logic in them making them very hard to read and test. As a result for this project I decided to use the MVVM architecture for the first time.

## Pods used
The only pod I used for this project is SwiftLint. There are two reasons I decided to use this pod:
  1. I wanted to enforce some code styles and standards to my project in order to make it look neat.
  2. To demonstrate my knowledge in using pods in case it's needed.

## Frameworks and design patterns used for the first time
 * This is the first time I'm using Swifts URLSession framework. I used it order to receive the apps data from the static API. The reason I decided to use it is because I decided that it would be better not to use many pods for the project.
 * I also used the Dependency Injection design pattern. I used this design pattern because in some cases I needed to have access to some functionality from other classes and I decided that in some cases it would be safer to use this design pattern instead of Singleton.

I realise that I most propably have not implemented them with the best practices, but I still decided to use them because I thought this project is a great opportunity for me to try and apply things I'm learning and didn't have the opportunity to use before.

## Other tools used
1. [Material icons](https://fonts.google.com/icons) for the icons displayed in the app.
2. [Haikei](https://app.haikei.app/) for the background image used at the apps launcscreen.
3. [Color Hunt](https://colorhunt.co/) for the colors used in the app.
4. Apples' PhotoScape X app for the app logo and creating the app icon.
5. Apples' Icon Set Creator app in order to generate the app icons.

