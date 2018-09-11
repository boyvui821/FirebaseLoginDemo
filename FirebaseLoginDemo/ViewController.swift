//
//  ViewController.swift
//  FirebaseLoginDemo
//
//  Created by Nguyen Hieu Trung on 9/11/18.
//  Copyright © 2018 NHTSOFT. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FBSDKCoreKit
import FBSDKLoginKit
import KRProgressHUD
import GoogleSignIn

class ViewController: UIViewController,GIDSignInUIDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        GIDSignIn.sharedInstance().uiDelegate = self
    }

    @IBAction func PressFBlogin(_ sender: Any) {
        FBSDKLoginManager().logIn(withReadPermissions: ["public_profile"], from: self) { (result, error) in
            if error != nil{
                print("Đã có lỗi xảy ra \(error)")
                return
            }
            
            KRProgressHUD.show();
            KRProgressHUD.show(withMessage: "Loading...")
            let accesstoken = FBSDKAccessToken.current()
            let strAccessToken = accesstoken?.tokenString;
            let credential = FacebookAuthProvider.credential(withAccessToken: strAccessToken!);
            
            
            Auth.auth().signIn(with: credential, completion: { (user, err) in
                KRProgressHUD.dismiss()
                
                if err != nil {
                    print("Lỗi đăng nhập FB với firebase");
                    return
                }
                
                
                print("Đăng nhập thành công với: \(user)");
            })
        }
    }
    
    @IBAction func PressGGlogin(_ sender: Any) {
        KRProgressHUD.show();
        GIDSignIn.sharedInstance().signIn();
    }
    
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        KRProgressHUD.dismiss();
    }
    


}

