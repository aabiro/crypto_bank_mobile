import UIKit
import Flutter
import GoogleMaps
import FBSDKCoreKit
import Firebase

//func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//
//    ApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
//    // Add any custom logic here.
//    return true
//}
//
//func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//
//    let handled = FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation])
//    // Add any custom logic here.
//    return handled
//}

//import FBSDKCoreKit/FBSDKCoreKit.h


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyDoid-JXRFRIZ1XO819NyuYaCISf7ljXFo")
    GeneratedPluginRegistrant.register(with: self)
//    FirebaseApp.configure()
    if(FirebaseApp.app() == nil){
        FirebaseApp.configure()
    }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
//    override init() {
//        FirebaseApp.configure()
//    }
    

    
//    //  AppDelegate.m
//
//    - (BOOL)application:(UIApplication *)application
//        didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//
//      [[FBSDKApplicationDelegate sharedInstance] application:application
//        didFinishLaunchingWithOptions:launchOptions];
//      // Add any custom logic here.
//      return YES;
//    }
//
//    - (BOOL)application:(UIApplication *)application
//                openURL:(NSURL *)url
//                options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
//
//      BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
//        openURL:url
//        sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
//        annotation:options[UIApplicationOpenURLOptionsAnnotationKey]
//      ];
//      // Add any custom logic here.
//      return handled;
//    }
      

}


