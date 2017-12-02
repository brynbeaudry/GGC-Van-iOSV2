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
        //let suG = DispatchGroup()
        //suG.enter()
        // Actually make the signup call passing in those attributes
        //LoginItems.sharedInstance.setEmail(email: tfEmail.text!)
        //LoginItems.sharedInstance.setPassword(pass: tfPassword.text!)
        let signUpItems = [tfEmail.text!, tfPassword.text!, tfUsername.text!]
        //let test = ["a@a.a", "qwerty"]
        //LoginItems.sharedInstance.setEmail(email: self.email.text!)
        //LoginItems.sharedInstance.setPassword(pass: self.password.text!)
        
        firstly {
            AD.customIdentityProvider!.signUp(email: signUpItems[0], password: signUpItems[1], username: signUpItems[2])
        }.then { message -> Void in
                if(message == "SUCCESS"){
                    self.afterSignUpSignIn()
                }else{
                    // Error in the signup process
                    let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler:nil))
                }
        }.catch { error in
            print(error)
        }
    }//end of getting sign up response from async task
        //suG.notify(queue: .main, execute: {self.afterSignUpSignIn()})
    
    func afterSignUpSignIn(){
        //authenticate user
        //let  lnDg = DispatchGroup()
        //lnDg.enter()
        AD.customIdentityProvider?.loginType = LoginType.EMAIL
        //let signUpItems = [tfEmail.text!, tfPassword.text!]
        
        // Sign in after sign up
        firstly {
            AD.customIdentityProvider!.token(LoginType.EMAIL, email: tfEmail.text!, password: tfPassword.text!)
        }.then { resp -> Void in
            //success message and deal with success
            //tokenDG.leave()
            if let message : String = resp as? String {
                print(message)
                if message == "EMAIL_LOGIN_SUCCESS" {
                    self.performSegueWithCompletion(id: "signUpBackToMain", sender: self, completion: {self.avDelegate?.authViewDidClose()})
                }
            }
        }.catch { error in
            print(error)
        }
    }
        
        /*
        lnDg.leave()
        
        lnDg.notify(queue: .main, execute: {
            self.performSegueWithCompletion(id: "signUpBackToMain", sender: self, completion: {self.avDelegate?.authViewDidClose()})
        })
         */
    
    func performSegueWithCompletion(id: String, sender: UIViewController,  completion: @escaping ()->()){
        self.avDelegate = self.AD.window?.rootViewController as? AuthViewDelegate
        self.performSegue(withIdentifier: id, sender: self)
        print("")
        completion()
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
