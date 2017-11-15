//
//  HTTPTest.swift
//  
//
//  Created by Bryn Beaudry on 2017-11-15.
//

import Foundation
import FBSDLoginKit
import FBSDCoreKit
import Alamofire

int main(int argc, char * argv[]) {
    NSString * const kUITestingLaunchArgument   = @"org.quellish.UITestingEnabled";
    
    print("hello")
    
    
    
    @autoreleasepool {
        if ([[NSUserDefaults standardUserDefaults] valueForKey:kUITestingLaunchArgument] != nil){
            return UIApplicationMain(argc, argv, nil, NSStringFromClass([TestingApplicationDelegate class]));
        } else {
            return UIApplicationMain(argc, argv, nil, NSStringFromClass([ProductionApplicationDelegate class]));
        }
    }
}
