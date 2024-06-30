//
//  AppDelegate.swift
//  shortcuts-sample
//
//  Created by Stelios Petrakis on 30/6/24.
//

import UIKit

// NOTE:
// In this sample we have added an empty Settings.bundle in the application
// target so that an entry is created in the Settings app.
// Normally you won't need that, as your application might already have a
// Settings entry.

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication,
                     willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UIApplication.updateShortcutItems()

        // NOTE:
        // Use this logic to process the shortcut item when the window-based app
        // is launched due to a shortcut being selected by the user.
        if let shortcutItem = launchOptions?[.shortcutItem] as? UIApplicationShortcutItem {
            UIApplication.handle(shortcutItem: shortcutItem)
        }
        return true
    }

    func application(_ application: UIApplication,
                     performActionFor shortcutItem: UIApplicationShortcutItem,
                     completionHandler: @escaping (Bool) -> Void) {
        // NOTE:
        // Use this logic to process the shortcut item when the window-based app
        // is already running.
        guard UIApplication.handle(shortcutItem: shortcutItem,
                                   completionHandler: completionHandler) else {
            completionHandler(false)
            return
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        let sceneConfiguration = UISceneConfiguration(name: "Default Configuration",
                                                      sessionRole: connectingSceneSession.role)
        sceneConfiguration.delegateClass = SceneDelegate.self
        return sceneConfiguration
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

