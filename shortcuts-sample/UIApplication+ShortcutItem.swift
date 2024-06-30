//
//  UIApplication+ShortcutItem.swift
//  shortcuts-sample
//
//  Created by Stelios Petrakis on 4/7/24.
//

import UIKit

let kShortcutItemSettingsType = "Settings"
let kShortcutItemNotificationSettingsType = "Notifications"
let kShortcutItemSettingsSFSymbol = "gear"
let kShortcutItemNotificationSettingsSFSymbol = "bell.badge"

extension UIApplication {
    /// Creates the shortcuts items of the application (Settings / Notification Settings) and assigns them
    /// to the `shortcutItems` property.
    static func updateShortcutItems() {
        UIApplication.shared.shortcutItems = [ Self.settingsShortcutItem() ]

        UNUserNotificationCenter.current().getNotificationSettings { settings in
            guard settings.authorizationStatus != .notDetermined else {
                return
            }
            DispatchQueue.main.async {
                UIApplication.shared.shortcutItems = [
                    Self.settingsShortcutItem(), Self.notificationSettingsShortcutItem()
                ]
            }
        }
    }

    /// - Returns: The 'View Settings' shortcut Item
    static func settingsShortcutItem() -> UIApplicationShortcutItem {
        let settingsIcon = UIApplicationShortcutIcon(systemImageName: kShortcutItemSettingsSFSymbol)
        let settingsTitle = NSLocalizedString("View Settings",
                                              comment: "Shortcut item title for Settings")
        return UIApplicationShortcutItem(type: kShortcutItemSettingsType,
                                         localizedTitle: settingsTitle,
                                         localizedSubtitle: nil,
                                         icon: settingsIcon)
    }

    /// - Returns: The 'View Notification Settings' shortcut Item
    static func notificationSettingsShortcutItem() -> UIApplicationShortcutItem {
        let notificationSettingsIcon = UIApplicationShortcutIcon(systemImageName: kShortcutItemNotificationSettingsSFSymbol)
        let notificationSettingsTitle = NSLocalizedString("View Notification Settings",
                                                          comment: "Shortcut item title for Notifications")
        return UIApplicationShortcutItem(type: kShortcutItemNotificationSettingsType,
                                         localizedTitle: notificationSettingsTitle,
                                         localizedSubtitle: nil,
                                         icon: notificationSettingsIcon)
    }

    
    /// Handlers the incoming request when user taps on a shortcut item and reports whether the request
    /// has been handled, offering a completion handler if needed.
    ///
    /// - Parameters:
    ///   - shortcutItem: The shortcut item selected by the user.
    ///   - completionHandler: The optional completion handler when the shortcut item request
    ///   is completed.
    /// - Returns: Whether the request has been handled or not.
    @discardableResult static func handle(shortcutItem: UIApplicationShortcutItem,
                                          completionHandler: ((Bool) -> Void)? = nil) -> Bool {
        var url: URL?
        if shortcutItem.type == kShortcutItemSettingsType {
           url = URL(string: UIApplication.openSettingsURLString)
        }
        else if shortcutItem.type == kShortcutItemNotificationSettingsType {
            url = URL(string: UIApplication.openNotificationSettingsURLString)
        }
        if let url = url {
            UIApplication.shared.open(url,
                                      options: [:],
                                      completionHandler: completionHandler)
            return true
        }
        else {
            return false
        }
    }
}
