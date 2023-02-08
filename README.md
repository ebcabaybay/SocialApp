# Social App

- Open **SocialApp.xcworkspace** and run the app
- All libraries used are already included in this repository

Minimum Software Requirement
- Xcode 14.0.1
- iOS Deployment Target 13.0

Sample Credentials
username: ejtest1@gmail.com
password: 123456

Features
- Sign Up, Sign In, and Sign Out
- User can add post with text and/or image
- User can delete own post
- Individual post view
- Handles both landscape and portrait orientations
- Implemented with MVVM architecture
- Unit testing

## Demo

### Sign Up, Sign In, and Sign Out
![ezgif-2-217c41d9f7](https://user-images.githubusercontent.com/1901338/217505472-74e44a69-6d4c-4b55-bfd9-b3a9cde835df.gif)

### Add, Delete, and View Post with Image
![ezgif-2-cb38324a5e](https://user-images.githubusercontent.com/1901338/217504924-a44642f6-fafb-4981-bba2-a03b1c3b7ece.gif)

## Architecture
The architecture pattern used in the project is MVVM (Model, View, ViewModel). This allows for a clearer separation of concerns and responsibility for each file in our code base.

- UI Layer
The UI Layer is implement via Storyboard, XIB files, and code

- Networking Layer
This is implemented in PostApiService and UserApiService via enums. Current backend used is Firebase APIs

- App Logic Layer
Core app logic are implemented via own view models for each class

- Models

User - represents a registered user with fullname, email, and password

Post - represents a post with and image and/or text a user can add an be displayed in the feed

## Testing

### Unit Testing
The following unit tests have been implemented

### UI Testing
