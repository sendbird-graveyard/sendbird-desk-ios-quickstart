//
//  AppDelegate.swift
//  SendBirdDeskTestBed
//
//  Created by Rommel Sunga on 12/12/19.
//  Copyright © 2019 Rommel Sunga. All rights reserved.
//

import UIKit
import SendBirdSDK
import SendBirdDesk

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Initialize SendBird Chat
        SBDMain.initWithApplicationId("192F73AB-EED6-465B-9B77-1F34406B5658")
        
        // Connect+Authenticate to SendBird Chat
        SBDMain.connect(withUserId: "test1", accessToken: "bc2603c5b3c84d512d4923efcb50475165db28fa", completionHandler: { (user, error) in guard error == nil else {
                print("Encountered Error while SBDMain.connect()")
                return
            }
            // Initialize SendBIrd Desk
            SBDSKMain.initializeDesk()
            
            // Connect+Authenticate to SendBird Desk
            SBDSKMain.authenticate(withUserId: "test1", accessToken: "bc2603c5b3c84d512d4923efcb50475165db28fa", completionHandler:{ (error) in guard error == nil else {
                    print("Encountered Error while SBDSKMain.authenticate(): " + error.debugDescription)
                    return
                }
                
                print("After SendBird Desk Authenticate")
                // Create Desk Ticket
                SBDSKTicket.createTicket(withTitle: "iOSDeskTestBedTicket", userName: "test1", completionHandler: { (ticket, error) in guard error == nil else {
                        print("Encountered Error while SBDSKMain.authenticate() " + error.debugDescription)
                        return
                    }
                    let messageText = "test message"
                    guard let params = SBDUserMessageParams(message: messageText) else { return }
          
                    ticket?.channel?.sendUserMessage(with: params) { (userMessage, error) in
                        guard error == nil else {   // Error.
                            return
                        }
                    }
                    print("Created Ticket Title = " + (ticket?.title)!)
                })
                
                // Get Desk Ticket List for Current User
                SBDSKTicket.getClosedList(withOffset: 0, completionHandler: { (ticketList, hasNext, error) in guard error == nil else {
                        print("Encountered Error while SBDSKTicket.getClosedList() " + error.debugDescription)
                        return
                    }
                    
                    print("Closed Ticket List Length = " + String(ticketList.count))
                    for ticket in ticketList {
                        print("Ticket Title = " + ticket.title!)
                    }
                    
                })
            })
            
        })
        return true
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

