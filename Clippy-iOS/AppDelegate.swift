//
//  AppDelegate.swift
//  Clippy-iOS
//
//  Created by Jakub Čermák on 21/05/2020.
//  Copyright © 2020 Jakub Čermák. All rights reserved.
//

import UIKit
import RealmSwift
import RxSwift
import RxRealm

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let disposeBag = DisposeBag()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
       
        
        
    
        return true
    }

    // MARK: UISceneSession Lifecycle

   
    
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    @objc func clipBChanged(){
        let pasteboard = UIPasteboard.general
        let newItem = PasteBoardItem()
        
        
        if pasteboard.hasStrings{
            newItem.type = "text"
        }
        
        if pasteboard.hasImages{
            newItem.type = "images"
        }
        print(newItem.content)
        print(newItem.type)
        newItem.content = pasteboard.string ?? "nothing in pasteboard"
        
        Observable.from(object: newItem)
            .subscribe(Realm.rx.add())
            .disposed(by: disposeBag)
        
    }
    
    
    
}

