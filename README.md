# Digital Trading Cards
Georgia Tech Capstone

An app to streamline the networking process by connecting students, professionals, and recruiters through matched skills and shared interests.

Client: Christen Steele

**Demo Video:** https://youtu.be/IDTbivJaiyQ 

# Release Notes:
**Version Number: 1.0.0**

**New Features:**
* Create your own personal card to summarize your experiences and skills.
* Add other people’s cards and make connections through one of two ways
* Add card through email search
* Add card through bluetooth connection
* View the cards that you have saved after adding another user by tapping on the view saved cards icon on the navigation bar.
* Users are able to favorite cards that they like, and the cards will be sorted to the top of their saved cards list.
* Users are able to favorite cards when adding or when viewing previously saved cards by tapping on the star icon.
* Users are able to register for events that are listed on the events screen, observe events that they have registered for, and view past events that they have attended.
* Users are able to create events and add detail pertaining to the event, and other users are able to join the event.
* Users can look at past event attendees list.

**Bug Fixes made since the last release:**
* Autocomplete for company names in card creation handles null cases
* Creating a card as a brand new user now works (previously had to logout and re-login)
* Some UI overflow errors were fixed for small screen devices

**Current Known Bugs and Defects:**
* NFC phone to phone communication on Android devices is deprecated and no longer supported.
* Bluetooth bug: Two devices cannot find each other via Bluetooth.
* Favoriting isn’t being recorded in the DB.
* Messaging bug: Messages don’t update in real-time. New messages do appear on page refresh/reload.

# Install Guide: 
**Pre-requisites:** 
Since we have not uploaded our application to the Google Play store or App Store, the customer can download the project folder from the repository. The customer will need a laptop that can run mobile application development. The customer will also need an iOS or android emulator to run the application on if they do not have an external mobile device they can connect the application to. 

**Dependent libraries that must be installed:**
Third party software that must be installed for our software to function is the Flutter SDK, Dart, and Aqueduct. 
Flutter SDK - https://flutter.dev/docs/get-started/install
Dart - https://dart.dev/get-dart
Aqueduct - https://aqueduct.io/docs/getting_started/

**Download instructions**
Until we upload our application to the Google Play store and App store, customers interested in our project can contact us to be given access to the repository of the code. Once given access, customer’s can then clone the folder and run the application either through a connected mobile device or an emulator. 

**Build instructions**
To build the application the users will simply need to download or clone the repo folder on to their local machine and follow the run instructions to run the application. 

### Installation of actual application
From the source code of our repository, the user will need to have all the directories located in the src folder of our repository. 

**Run instructions**
To execute the software, the customer should first either start up an emulator or connect a mobile device to their computer. Once a device is connected, then the customer should open two command prompts (or terminals). In one prompt, the customer should navigate to the src/ui directory and then run ‘flutter run’ if a device is running and connected. If the customer needs to connect an emulator the customer can run the command ‘flutter emulators --create [emulator-name]’, ‘‘flutter emulators --launch [emulator-name]’, and finally ‘flutter run’. After running ‘flutter run’, the application should run on the connected device and the user should see the Wisteria home page. 
If the customer wishes to run the server, they can navigate to the src/server directory in the other prompt and run the command 'aqueduct serve’. 

**Troubleshooting:**
Make sure environment paths are set correctly for Flutter SDK and the dart bin, as well as packages installed for both. 
https://dartcode.org/docs/configuring-path-and-environment-variables/#:~:text=Windows,edit%20or%20add%20new%20ones.

*Adjusting Path*
Windows OS:
https://flutter.dev/docs/get-started/install/windows
Mac OS:
https://flutter.dev/docs/get-started/install/macos

## Credits
Noah Le - noah3@gatech.edu
Mariana Matias - mariana@gatech.edu
Pratik Nallamotu - pratiknallamotu@gatech.edu
Matt Oliver - moliver39@gatech.edu
Patrick Ufer - pufer3@gatech.edu
Ashvin Warrier - awarrier@gatech.edu

## Good code practices
### Commit messages:
For commiting, if you’re using git from the command line, a good standard commit message is:

```git commit -m "Issue: #X - [short message explaining what you did]"```

Example:

```git commit -m "Issue: #6 - Altered project organization for UI assets"```