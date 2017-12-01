//
//  SignUpViewController.swift
//  GGCVan Client
//
//  Created by Bryn Beaudry on 2017-10-22.
//  Copyright © 2017 Bryn Beaudry. All rights reserved.
//

import UIKit
import AWSCore
import AWSCognito
import AWSCognitoIdentityProvider
import Alamofire;
import EVReflection
import PromiseKit

class SignUpViewController: UIViewController {
    var avDelegate: AuthViewDelegate?
    let AD = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordConfirm: UITextField!
    
    
    @IBAction func signupPressed(_ sender: Any) {
        // Get a reference to the user pool
        // Collect all of the attributes that should be included in the signup call
        //check password
        if(password.text == passwordConfirm.text){
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
        //LoginItems.sharedInstance.setPassword(pass: tfPassword.text!)
        let _ = [password.text!, password.text!]
        let test = ["a@a.a", "qwerty"]
        
        
        firstly {
            AD.customIdentityProvider.signUp(email: test[0], password: test[1])
            } .then { message in
                print(message)
                if(message == "SUCCESS")
            } .catch {
                
        }
        AD.customIdentityProvider.signUp(email: test[0], password: test[1])
            .continueWith { (response) -> Any? in
                if response.error != nil {
                    // Error in the signup process
                    let alert = UIAlertController(title: "Error", message: response.error?.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler:nil))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    // Does user need verification?
                    print("Response Result : \(String(describing: response.result))")
                    //if the user needs verification
                    if (!Bool(truncating: (response.result?.userConfirmed)!)) {
                        print("User Not confirmed")
                        // User needs confirmation, so we need to proceed to the verify view controller
                    } else {
                        // basically, you signed up sucessfully
                        print("User Debug no verification: \(response.result!.user)")
                        //set login items
                        DispatchQueue.main.async{
                            LoginItems.sharedInstance.setEmail(email: self.email.text!)
                            LoginItems.sharedInstance.setPassword(pass: self.password.text!)
                        }
                        suG.leave()
                    }//end of user signup/sign in successful
                }//end of user doesn't need to be verified
                return nil //returning sign up
        }//end of getting sign up response from async task
        suG.notify(queue: .main, execute: {self.afterSignUpSignIn()})
    }
    
    func afterSignUpSignIn(){
        //authenticate user
        let  lnDg = DispatchGroup()
        lnDg.enter()
        AD.customIdentityProvider?.loginType = LoginType.EMAIL
        
        // Sign in after sign up
        
        lnDg.leave()

        lnDg.notify(queue: .main, execute: {
            self.performSegueWithCompletion(id: "signUpBackToMain", sender: self, completion: {self.avDelegate?.authViewDidClose()})
        })
    }
    
    func performSegueWithCompletion(id: String, sender: UIViewController,  completion: @escaping ()->()){
        self.avDelegate = self.AD.window?.rootViewController as? AuthViewDelegate
        self.performSegue(withIdentifier: id, sender: self)
        print("")
        completion()
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        print("Debug pool in Vc \(AD.pool?.debugDescription)")
        
        
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
