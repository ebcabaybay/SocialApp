# Social App

- Open **SocialApp.xcworkspace** and run the app
- All libraries used are already included in this repository

## Minimum Software Requirement
- Xcode 14.0.1
- iOS Deployment Target 13.0

## Sample Credentials
username: ejtest1@gmail.com\
password: 123456

## Features
- Sign Up, Sign In, and Sign Out
- User can add post with text and/or image
- User can delete own post
- Individual post view
- Handles both landscape and portrait orientations
- Implemented with MVVM architecture
- Unit testing

## Demo

| Sign Up, Sign In, and Sign Out | Add, Delete, and View Post with Image |
|--------------------------------|---------------------------------------|
|![ezgif-2-217c41d9f7](https://user-images.githubusercontent.com/1901338/217505472-74e44a69-6d4c-4b55-bfd9-b3a9cde835df.gif)|![ezgif-2-cb38324a5e](https://user-images.githubusercontent.com/1901338/217504924-a44642f6-fafb-4981-bba2-a03b1c3b7ece.gif)|

## Architecture
The architecture pattern used in the project is MVVM (Model, View, ViewModel). This allows for a clearer separation of concerns and responsibility for each file in our code base.

### UI Layer
The UI Layer is implement via Storyboard, XIB files, and code

### Networking Layer
This is implemented in PostApiService and UserApiService via enums. Current backend used is Firebase APIs

### App Logic Layer
Core app logic are implemented via own view models for each class

### Models

User - represents a registered user with fullname, email, and password

Post - represents a post with and image and/or text a user can add an be displayed in the feed

## Testing

### Unit Testing
The following unit tests have been implemented. Most view models have 100% code coverage\
<img width="357" alt="Screen Shot 2023-02-09 at 6 38 47 AM" src="https://user-images.githubusercontent.com/1901338/217672191-c96c588b-339a-4df5-af4d-a08f32a45c67.png">

### UI Testing
UI Testing is implement via XCUITest framework
![ezgif-2-f70d529284](https://user-images.githubusercontent.com/1901338/217688236-0e2dba43-abae-4790-9b75-af27b872970b.gif)

