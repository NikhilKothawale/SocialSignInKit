# SocialSignInKit

>SocialSignInKit is a multiple social sign-in kit. Support for Apple, Google, and Facebook sign-in.

----------

- [Requirements](#requirements)
- [Installation](#installation)
* Setup
    - [Apple](#apple)
    - [Google](#google)
    - [Facebook](#facebook)
 
 ______

 **NOTE**

Apps that use a third-party or social login service (such as Facebook Login, Google Sign-In) to set up or authenticate the user’s primary account with the app must also offer Sign in with Apple as an equivalent option. This is as per the [App Store Review Guidelines](https://developer.apple.com/app-store/review/guidelines/#sign-in-with-apple).

------------

## Requirements
* iOS 13.0+
* Xcode 11+
* Swift 4.2+

-----------

## Installation

[CocoaPods](https://cocoapods.org/ "CocoaPods") is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website.
To integrate SocialSignInKit into your Xcode project using CocoaPods, specify it in your Podfile:

```
pod 'SocialSignInKit', '~> 1.0'
```

---------------------

## Apple

### Enable Sign-in with Apple in App Identifier

 Head over to [Apple developer center](https://developer.apple.com/account/), select "Certificates, Identifier and Profiles",
 
 select the corresponding App Identifier in the Identifiers list, and check the "Sign-in with Apple" capability and click "Save".

### Enable Sign-in with Apple capability in Xcode

Under the Xcode project file, there is Signing & Capabilities available. Press on the + and add the “Sign In with Apple” capability. Adding the capability will create appropriate entitlements file and the right framework.

### Setting up Sign-in with Apple button UI

To use "Sign-in with Apple" function, you have to use the specially designated ASAuthorizationAppleIDButton class, you can't use your own custom button or risk rejection by App Review team.

Unfortunately there's no storyboard / XIB option for this button, we have to add it programmatically to our view controller / view.

We have to import the AuthenticationServices before using Sign-in with Apple button.
```Swift
import AuthenticationServices

class ViewController: UIViewController {
  //...
}
```
Then in viewDidLoad() function, add the sign-in with Apple button :

```Swift

override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
 if #available(iOS 13.0, *) {
            var _: ASAuthorizationAppleIDButton = {
                let appleSignInButton = self.appleSignInButtonUIView()
                appleSignInButton.addTarget(self, action: #selector(appleSignInButtonClicked), for: .touchDown)
                return appleSignInButton
            }()
        }
}

// This is the function that will be executed when user tap the button
@available(iOS 13.0, *)
    @objc func appleSignInButtonClicked(){
        let appleSignInManager =  AppleSignInManager.shared
        appleSignInManager.presentingController = self
        appleSignInManager.signIn()
    }

   // This function creates the apple SignIn Button
    @available(iOS 13.0, *)
    func appleSignInButtonUIView() -> ASAuthorizationAppleIDButton{
        let appleSignInButton: ASAuthorizationAppleIDButton
        
        if #available(iOS 13.2, *) {
            appleSignInButton = ASAuthorizationAppleIDButton(type: .signUp, style: .black)
        }else{
            appleSignInButton = ASAuthorizationAppleIDButton(type: .signIn, style: .black)
        }
        
        appleSignInButton.translatesAutoresizingMaskIntoConstraints = false
        
        innerView.addSubview(appleSignInButton)
    
        NSLayoutConstraint.activate([
            appleSignInButton.leadingAnchor.constraint(equalTo: view.appleSignInButton.leadingAnchor, constant: 50.0),
            appleSignInButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50.0),
            appleSignInButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70.0),
            appleSignInButton.heightAnchor.constraint(equalToConstant: 50.0)
        ])
        
        return appleSignInButton
    }
}
```

After adding the apple sigin button in your ViewController, you need to  import the SocialSignInKit and extend AppleSignInManagerDelegate in your ViewController.

```Swift
import SocialSignInKit

extension ViewController: AppleSignInManagerDelegate{
    func appleSignIn(didCompleteWithUser appleUser: AppleUser){

    }

    func appleSignIn(didCompleteWithError error: Error){

    }
}
```
The function didCompleteWithUser return the users information like name, email, userId, etc.

--------

## Google

### Create OAuth credentials via the Google Developer Console

Sign into the [Google Developer Console](https://console.developers.google.com/) and follow the steps below:

* Create or select a project
* Go to the project’s [credentials page](https://console.developers.google.com/apis/credentials)
* Create an OAuth Client ID
* You’ll be asked to fill out the required sections of the OAuth Consent Screen form if they’re missing. This information is presented to the user when they’re asked to grant your app permission to make requests on the behalf of their Google Account.
* Fill in the form with your app information.
* Download the .plist that contains the client ID and URL scheme (reverse client ID) by clicking the **download** button.
* Add the downloaded .plist file in your project.

### Import the GoogleSignIn SDK

[Cocoapods](https://cocoapods.org/ "CocoaPods") is the recommended delivery method for the SDK.
Add the following to your Podfile:

```swift
pod 'GoogleSignIn'
```

### Setup Google Sign In in your app

Once the SDK has been included in your app, you’ll need to do the following:

* Add a custom URL scheme to your app target. The value should be set to the REVERSED_CLIENT_ID value in the .plist containing your Google credentials.

* Next, open ```AppDelegate.swift``` and import GoogleSignIn module and SocialSignInKit.

```swift
import GoogleSignIn
import SocialSignInKit
```

* After that, add the following 2 lines of code into application```(_:didFinishLaunchingWithOptions:)```.

```swift
GIDSignIn.sharedInstance().delegate = self

GIDSignIn.sharedInstance().clientID = GoogleService.shared.clientID

```

* Next, add the following `AppDelegate` method implementation right after `application(_:didFinishLaunchingWithOptions:)`.

```swift
func application(_ app: UIApplication,
                 open url: URL,
                 options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {

    return GIDSignIn.sharedInstance().handle(url)
}
```

### Sign-in and Sign-out Workflow Implementation

Create a storyboard / XIB option Google Sign-in/Sign-out button in your ViewController, you need to import GoogleSignIn and SocialSignInKit in the ViewController.

```swift
import GoogleSignIn
import SocialSignInKit

class ViewController: UIViewController {
  //...
}

```

In the Sign-in and Sign-out button action outlets add the following code respectively.
```swift

@IBAction func googleSignInButtonClicked(_ sender: Any) {
        GoogleSignInManager.shared.signIn()
    }

@IBAction func googleSignOutButtonClicked(_ sender: Any) {
        GoogleSignInManager.shared.signOut()
    }

```

After this you need to extend GoogleSignInManagerDelegate in your ViewController which has Sign-in button.

```swift 
import SocialSignInKit

extension ViewController: GoogleSignInManagerDelegate{
    func googleSignIn(didCompleteWithUser googleUser: GoogleUser){

    }

    func googleSignIn(didCompleteWithError error: Error){

    }    
}

```
The function didCompleteWithUser return the users information like name, email, userId, etc.

---------

## Facebook

### Add your app on the ‘facebook for developers’ website

Go to [facebook for developers](https://developers.facebook.com/) and add your app from ‘My App’ button top right side of the page.

### Install dependencies using Cocoapods

Add the following to your Podfile:

```swift
pod 'FBSDKCoreKit'
pod 'FBSDKLoginKit'
```

### Configure your app on Facebook

Assuming you are still on your facebook for developers app page. You will see thumbnails of the services that Facebook provides. Click the ‘Set up’ button on the ‘Facebook Login’ thumbnail. Then you will be asked which platform to use, so just select iOS.

Then you will see the configuration screen.

Basically, you can just follow the instructions.

Add the given XML snippet to ‘info.plist’ to configure the information. In your Xcode project navigator, look for info.plist, right click the info.plist file and select Open As → Source Code. The XML snippet looks something like this.

```XML
<key>CFBundleURLTypes</key>
<array>
  <dict>
  <key>CFBundleURLSchemes</key>
  <array>
    <string>fb1111111111111111</string>
  </array>
  </dict>
</array>
<key>FacebookAppID</key>
<string>YourAppIDComesHere</string>
<key>FacebookDisplayName</key>
<string>YourProjectNameComesHere</string>
// Below is to use any of the Facebook dialogs
<key>LSApplicationQueriesSchemes</key>
<array>
  <string>fbapi</string>
  <string>fb-messenger-share-api</string>
  <string>fbauth2</string>
  <string>fbshareextension</string>
</array>
```

### Integrate iOS App with Facebook SDK

Open up `AppDelegate.swift` and import FBSDKCoreKit.

```swift
import FBSDKCoreKit
```

Next, add following code snippet to the `application(_:didFinishLaunchingWithOptions:)` method.

```swift
ApplicationDelegate.shared.application(
    application,
    didFinishLaunchingWithOptions:
    launchOptions
)
```

Finally add following method to `AppDelegate.swift`.

```swift
func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    return ApplicationDelegate.shared.application(
        app,
        open: url,
        options: options
    )
}
```

### Adding FBLoginButton to your ViewController

First, import FBSDKLoginKit to your view controller.

```swift
import FBSDKLoginKit
```

Create a storyboard / XIB option Facebook Sign-in/Sign-out button in your ViewController. 

In the Sign-in and Sign-out button action outlets add the following code respectively.

```swift
@IBAction func facebookSignInButtonClicked(_ sender: Any) {
        FacebookSignInManager.shared.signIn()
    }

@IBAction func facebookSignOutButtonClicked(_ sender: Any) {
        FacebookSignInManager.shared.signOut()
    }
```

After this you need to extend FacebookSignInManagerDelegate in your ViewController which has Sign-in button.

```swift 
import SocialSignInKit

extension ViewController: GoogleSignInManagerDelegate{
    func facebookSignIn(didCompleteWithUser facebookUser: FacebookUser){

    }

    func facebookSignIn(didCompleteWithError error: Error){

    }
}
```
The function didCompleteWithUser return the users information like name, email, userId, etc.

-----------------------

## License

SocialSignInKit is released under the MIT license. [See LICENSE](https://github.com/NikhilKothawale/SocialSignInKit/blob/master/LICENSE) for details.
