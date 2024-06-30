//
//  ViewController.swift
//  shortcuts-sample
//
//  Created by Stelios Petrakis on 30/6/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var notificationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateButtonVisibility()
    }
    
    @IBAction func requestNotificationAccess(_ sender: Any) {
        UNUserNotificationCenter
            .current()
            .requestAuthorization(options: [.badge, .alert]) { [weak self]
                granted, error in
                DispatchQueue.main.async {
                    UIApplication.updateShortcutItems()
                }
                self?.updateButtonVisibility()
            }
    }

    private func updateButtonVisibility() {
        UNUserNotificationCenter.current().getNotificationSettings { [weak self] settings in
            DispatchQueue.main.async {
                self?.notificationButton.isHidden = settings.authorizationStatus != .notDetermined
            }
        }
    }
}

