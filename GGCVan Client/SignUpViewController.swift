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

class SignUpViewController: UIViewController, AWSCognitoIdentityPasswordAuthentication {
    var avDelegate: AuthViewDelegate?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordConfirm: UITextField!
    
    func getDetails(_ authenticationInput: AWSCognitoIdentityPasswordAuthenticationInput, passwordAuthenticationCompletionSource: AWSTaskCompletionSource<AWSCognitoIdentityPasswordAuthenticationDetails>) {
        //using inputs from login UI create an AWSCognitoIdentityPasswordAuthenticat``ionDetails object.
        //These values are hardcoded for this example.
        print("username: \(LoginItems.sharedInstance.email!), password: \(LoginItems.sharedInstance.password!)")
        passwordAuthenticationCompletionSource.set(result: AWSCognitoIdentityPasswordAuthenticationDetails(username: LoginItems.sharedInstance.email!, password: LoginItems.sharedInstance.password!))
    }
    
    
    func didCompleteStepWithError(_ error: Error?) {
        DispatchQueue.main.async(execute: {() -> Void in
            //present error to end user
            if error != nil {
                let alert = UIAlertController.init(title: (error?.localizedDescription)!, message: (error?.localizedDescription)!, preferredStyle: .alert)
                self.present(alert, animated: true)
            }
            else {
                //dismiss view controller
                //we are logged in
                print("LOGGED IN")
            }
        })
    }
    
    @IBAction func signupPressed(_ sender: Any) {
        // Get a reference to the user pool
        // Collect all of the attributes that should be included in the signup call
        let emailAttribute = AWSCognitoIdentityUserAttributeType(name: "email", value: email.text!)
        let userNameAttribute = AWSCognitoIdentityUserAttributeType(name: "preferred_username", value: userName.text!)
        //check password
        let suG = DispatchGroup()
        if(password.text == passwordConfirm.text){
        suG.enter()
        // Actually make the signup call passing in those attributes
            appDelegate.pool?.signUp(email.text!, password: password.text!, userAttributes: [emailAttribute, userNameAttribute], validationData: nil)
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
                        // User signed up but does not need verification
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
        }//end of form validation
    }
    
    func afterSignUpSignIn() -> Void {
        //authenticate user
        let  lnDg = DispatchGroup()
        lnDg.enter()
        self.appDelegate.pool?.getUser().getDetails().continueOnSuccessWith(block: {(_ task: AWSTask<AWSCognitoIdentityUserGetDetailsResponse>) -> Any? in //begin
            
            //continue with success operation for signin
            let response: AWSCognitoIdentityUserGetDetailsResponse? = task.result
            print("response: \(response.debugDescription)")
            for attribute in (response?.userAttributes)! {
                //print the user attributes
                print("Attribute: \(attribute.name ?? "none") Value: \(attribute.value ?? "none")")
            }
            //unwind to main area
            print("Self view controller. \(self.debugDescription)")
            //performuniwnd segue
            //end of async cocastuff
            lnDg.leave()
            return nil
        }) //end of async sign in task
        lnDg.wait()
        self.performSegueWithCompletion(id: "signUpBackToMain", sender: self, completion: {self.avDelegate?.authViewDidClose()})
    }
    
    func performSegueWithCompletion(id: String, sender: UIViewController,  completion: @escaping ()->()){
        self.avDelegate = self.appDelegate.window?.rootViewController as? AuthViewDelegate
        self.performSegue(withIdentifier: id, sender: self)
        print("")
        completion()
        /*
         let ops : [BlockOperation] = [
         BlockOPeration(block : {self.performSegue(withIdentifier: id, sender: self)}),
         BlockOperation(block: {self.avDelegate = self.appDelegate.window?.rootViewController as? AuthViewDelegate}),
         
         //b is the completion
         let b = BlockOperation(block: {()->Void in completion()})
         b.addDependency(a)
         let ops : [BlockOperation] = [a,b]
         weak var oq = OperationQueue.main
         oq?.addOperations(ops, waitUntilFinished: true)
         */
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        print("Debug pool in Vc \(appDelegate.pool?.debugDescription)")
        
        
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
