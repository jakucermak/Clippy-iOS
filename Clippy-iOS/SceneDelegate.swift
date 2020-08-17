//
//  SceneDelegate.swift
//  Clippy-iOS
//
//  Created by Jakub Čermák on 21/05/2020.
//  Copyright © 2020 Jakub Čermák. All rights reserved.
//

import UIKit
import RealmSwift


class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    let realm = try! Realm()
    let clippyLogic = ClippyLogic()
    
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(clipBChanged), name: UIPasteboard.changedNotification, object: nil)
        
        
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        
        
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        
        clipBChanged()
        
        
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    @objc func clipBChanged(){
        
        let newItem = PasteBoardItem()
        let pasteboard = UIPasteboard.general
        
        
        if pasteboard.hasImages{
          print(clippyLogic.checkForData(pasteboard: pasteboard))
            newItem.contentImage = NSData(data:pasteboard.image!.jpegData(compressionQuality: 0.9)!)
            newItem.type = "image"
            newItem.id = realm.objects(PasteBoardItem.self).count + 1
            
            do{
                try realm.write{
                    realm.add(newItem)
                }
            }catch{

            }
            
        }
        
        if clippyLogic.checkForStrings(newItem: newItem, pasteboard: pasteboard) == 0 {
            if pasteboard.hasStrings{
                newItem.contentText = pasteboard.string ?? "Error: contains nil"
                newItem.type = "text"
                newItem.id = realm.objects(PasteBoardItem.self).count + 1
                do{
                    try realm.write{
                        realm.add(newItem)
                    }
                }catch{
                    
                }
                
            }
            
        }
    }
    
}
