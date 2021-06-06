//
//  AppDelegate.swift
//  SocialNetwork
//
//  Created by rayner on 10/05/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        setupAppearance()
        return true
    }
    
    private func setupAppearance() {
        let tabBar = UITabBar.appearance()
        tabBar.barTintColor = UIColor.red
        tabBar.tintColor = UIColor.white
        tabBar.unselectedItemTintColor = UIColor.white
        tabBar.isTranslucent = false
        
        let navBar = UINavigationBar.appearance()
        navBar.barTintColor = UIColor.red
        navBar.tintColor = UIColor.white
        navBar.isTranslucent = false
        navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
//        // Create the attributed string
//        let texto = NSMutableAttributedString(string:"Enter your text here.")
//
//        // Declare the fonts
//        let textoFont1 = UIFont(name:"Helvetica", size:14.0)!
//        let textoFont2 = UIFont(name:"Helvetica-Bold", size:14.0)!
//
//        // Create the attributes and add them to the string
//        texto.addAttribute(NSAttributedString.Key.font, value:textoFont1, range:NSRange(location: 0, length: 16))
//        texto.addAttribute(NSAttributedString.Key.font, value:textoFont2, range:NSRange(location: 16, length: 4))
//        texto.addAttribute(NSAttributedString.Key.font, value:textoFont1, range:NSRange(location: 20, length: 1))
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


}

