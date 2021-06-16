//
//  ViewController.swift
//  local-swift-notifi
//
//  Created by quan bui on 2021/05/28.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var localNotifi: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        localNotifi.addTarget(self, action: #selector(fireNotification), for: .touchUpInside);
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { comple, error in
            if error != nil {
                print(error as Any)
            }
        }
    }

    @objc func fireNotification() {
        self.sendNotification()
    }

    var n = 1;
    func sendNotification() {
        let currentBadge: NSNumber = NSNumber(value: UIApplication.shared.applicationIconBadgeNumber + 1)
        let content = UNMutableNotificationContent()
        content.title = "No \(n)"
        content.subtitle = "subtitle message \(n)"
        content.body = "body of local notification \(n)"
        content.badge = currentBadge
        content.sound = UNNotificationSound(named: UNNotificationSoundName("sample.aiff"))

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let identifier = "demoIdentifier\(n)"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { err in
            if err != nil {
                print(err as Any)
            }
            self.n += 1
        }
    }
}
