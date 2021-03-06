//
//  AppDelegate.swift
//  FirebaseLoginDemo
//
//  Created by Nguyen Hieu Trung on 9/11/18.
//  Copyright © 2018 NHTSOFT. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn
import KRProgressHUD

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //Firebase Configure
        FirebaseApp.configure();
        
        //Facebook
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions);
        
        //Google
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID;
        GIDSignIn.sharedInstance().delegate = self
        
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        var handled = false;
        if (url.scheme == "fb\(FBSDKSettings.appID())"){
            handled = FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
        }else{
            handled = GIDSignIn.sharedInstance().handle(url, sourceApplication: sourceApplication, annotation: annotation);
        }
        
        return handled;
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil{
            print("Có lỗi xảy ra khi đăng nhập với Google")
        }
        
        var authentication = user.authentication;
        var credential = GoogleAuthProvider.credential(withIDToken: (authentication?.idToken)!, accessToken: (authentication?.accessToken)!);
        
        KRProgressHUD.show();
        Auth.auth().signIn(with: credential) { (user, err) in
            KRProgressHUD.dismiss();
            if err != nil{
                print(error)
                return
            }
            
            print(user);
        }
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

