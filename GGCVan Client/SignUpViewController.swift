//
//  SignUpViewController.swift
//  GGCVan Client
//
//  Created by Bryn Beaudry on 2017-10-22.
//  Copyright © 2017 Bryn Beaudry. All rights reserved.
//

import UIKit
import Alamofire
import PromiseKit
import EVReflection
import SwiftyJSON

class SignUpViewController: UIViewController {
    var avDelegate: AuthViewDelegate?
    let AD = UIApplication.shared.delegate as! AppDelegate


    @IBOutlet var tfEmail: UITextField!
    @IBOutlet var tfPassword: UITextField!
    @IBOutlet var tfConfirmPassword: UITextField!
    @IBOutlet var tfUsername: UITextField!
    
    @IBAction func signupPressed(_ sender: Any) {
        // Get a reference to the user pool
        // Collect all of the attributes that should be included in the signup call
        //check password
        if(tfPassword.text == tfConfirmPassword.text){
            getSignUpResponse()
        }else{
            let alert = UIAlertController(title: "Error", message: "Passwords don't match", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler:nil))
            self.present(alert, animated: true, completion: nil)
        }//end of form validation
    }
    
    
    func getSignUpResponse(){
        let suG = DispatchGroup()
        suG.enter()
        // Actually make the signup call passing in those attributes
        //LoginItems.sharedInstance.setEmail(email: tfEmail.text!)
        //let test = ["a@a.a", "qwerty"]
        //LoginItems.sharedInstance.setEmail(email: self.email.text!)
        //LoginItems.sharedInstance.setPassword(pass: self.password.text!)
        var signUpSuccess : Bool = false
        firstly {
            //let signUpItems : [String] = [self.tfEmail.text!, self.tfPassword.text!, self.tfUsername.text!]
            //let signUpItems : [String] = [self.tfEmail.text!, self.tfPassword.text!, self.tfUsername.text!]
            AD.customIdentityProvider!.signUp(email: self.tfEmail.text!, password: self.tfPassword.text!, username: self.tfUsername.text!)
        }.then { message -> Void in
                if(message == "SUCCESS"){
                    //self.afterSignUpSignIn()
                    signUpSuccess = true
                }else{
                    // Error in the signup process
                    let alert = UIAlertController(title: "Error", message: message , preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler:nil))
                }
            suG.leave()
        }.catch { error in
            print(error)
        }
        suG.notify(queue: .main, execute: {
            if  signUpSuccess {
                self.afterSignUpSignIn()
            }
        })
        
    }//end of getting sign up response from async task
    
    
    func afterSignUpSignIn(){
        //authenticate user
        let  lnDg = DispatchGroup()
        lnDg.enter()
        AD.customIdentityProvider?.loginType = LoginType.EMAIL
        //let signUpItems = [tfEmail.text!, tfPassword.text!]
        var signInSuccess = false
        // Sign in after sign up
        firstly {
            AD.customIdentityProvider!.token(LoginType.EMAIL, email: self.tfEmail.text!, password: self.tfPassword.text!)
        }.then { resp -> Void in
            //success message and deal with success
            //tokenDG.leave()
            if let message : String = resp as? String {
                print(message)
                if message == "EMAIL_LOGIN_SUCCESS" {
                    print("end of after sign in sign up")
                    signInSuccess = true
                }
                lnDg.leave()
            }else{
                print("couldn't read message")
                lnDg.leave()
            }
        }.catch { error in
            print(error)
        }
        lnDg.notify(queue: .main, execute : {
            if signInSuccess {
                    self.dismiss(animated: true, completion: {
                        self.performSegue(withIdentifier: "signUpBackToMain", sender: self)
                        self.avDelegate = self.AD.window?.rootViewController as? AuthViewDelegate
                        self.avDelegate?.authViewDidClose()
                    })
            }
        })
    }
        
        /*
        lnDg.leave()
        
        lnDg.notify(queue: .main, execute: {
            self.performSegueWithCompletion(id: "signUpBackToMain", sender: self, completion: {self.avDelegate?.authViewDidClose()})
        })
         */
    
    func performSegueWithCompletion(id: String, sender: UIViewController,  completion: @escaping ()->()){
        self.avDelegate = self.AD.window?.rootViewController as? AuthViewDelegate
        //let dgBackToMain = DispatchGroup()
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: id, sender: self)
            completion()
        }
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
