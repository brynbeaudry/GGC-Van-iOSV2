//
//  AppDelegate.swift
//  GGCVan Client
//
//  Created by Bryn Beaudry on 2017-10-20.
//  Copyright © 2017 Bryn Beaudry. All rights reserved.
//

import UIKit
import CoreData
import AWSCore
import AWSCognito
import AWSCognitoIdentityProvider
import GoogleSignIn
import Google

#if !Bridge_header_h
    //#define Bridge_header_h
#endif


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, AWSCognitoIdentityInteractiveAuthenticationDelegate {
    
    let path = Bundle.main.path(forResource: "Config", ofType: "plist")
    let clientIdGoogle : String! = nil
    var cognitoConfig : NSDictionary! = nil
    var window: UIWindow?
    var pool: AWSCognitoIdentityUserPool?
    var credentialsProvider: AWSCognitoCredentialsProvider?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // set up logging for AWS and Cognito
        AWSDDLog.sharedInstance.logLevel = .verbose
        AWSDDLog.add(AWSDDTTYLogger.sharedInstance)
        
        // set up Cognito config
        let path = Bundle.main.path(forResource: "CognitoConfig", ofType: "plist")
        self.cognitoConfig = NSDictionary(contentsOfFile: path!)
        
        // set up Cognito
        setupCognitoUserPoolAndCredentialsProvider()
        
        //set up Google SignIn
        //var configureError: NSError?
        //GGLContext.sharedInstance().configureWithError(&configureError)
        //assert(configureError == nil, "Error configuring Google services: \(configureError)")
        GIDSignIn.sharedInstance().clientID = String("986909663782-kn9h7jqgmnncggq00elr2d29j391i25c.apps.googleusercontent.com")
        
        
        return true
    }
    
    //appearantly only required for older versions?
    private func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : AnyObject] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String, annotation: options[UIApplicationOpenURLOptionsKey.annotation]) ? true : false
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
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "GGCVan_Client")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func setupCognitoUserPoolAndCredentialsProvider() {
        // we pull the needed values from the CognitoConfig object
        // this just pulls the values in from the plist
        let clientId:String = self.cognitoConfig.value(forKeyPath: "clientId") as! String
        let poolId:String = self.cognitoConfig.value(forKeyPath: "poolId") as! String
        let clientSecret:String = self.cognitoConfig.value(forKeyPath: "clientSecret") as! String
        let region:AWSRegionType = AWSRegionType.USWest2
        
        // we need to let Cognito know which region we plan to connect to
        let serviceConfiguration:AWSServiceConfiguration = AWSServiceConfiguration(region: region, credentialsProvider: nil)
        // we need to pass it the clientId and clientSecret from the app and the poolId for the user pool
        let cognitoConfiguration:AWSCognitoIdentityUserPoolConfiguration = AWSCognitoIdentityUserPoolConfiguration(clientId: clientId, clientSecret: clientSecret, poolId: poolId)
        AWSCognitoIdentityUserPool.register(with: serviceConfiguration, userPoolConfiguration: cognitoConfiguration, forKey: poolId)
        pool = AWSCognitoIdentityUserPool(forKey: poolId)
        print("Debug pool in AD \(pool?.debugDescription)")
        credentialsProvider = AWSCognitoCredentialsProvider(regionType: region, identityPoolId: poolId, identityProviderManager: pool)
        AWSServiceManager.default().defaultServiceConfiguration = serviceConfiguration
        // we need to set the AppDelegate as the user pool's delegate, which will get called when events occur
        pool?.delegate = self
    }
    
    func startPasswordAuthentication() -> AWSCognitoIdentityPasswordAuthentication {
        //implement code to instantiate and display login UI here
        //return something that implements the AWSCognitoIdentityPasswordAuthentication protocol
        return LoginViewController()
    }
}



