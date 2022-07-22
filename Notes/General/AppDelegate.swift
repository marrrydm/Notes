//  AppDelegate.swift
//  Notes
//
//  Created by Мария Ганеева on 28.03.2022.
//

import UIKit
import UserNotifications
import CoreData

@main

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let notificationsCenter = UNUserNotificationCenter.current() // для регистрации уведомлений в приложении

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [
            UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        authRequest()
        notificationsCenter.delegate = self
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        return UISceneConfiguration(
            name: "Default Configuration",
            sessionRole: connectingSceneSession.role
        )
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }

    // разрешение или запрет уведомлений
    func authRequest() {
        let options = UNAuthorizationOptions([.alert, .badge, .sound])
        notificationsCenter.requestAuthorization(options: options, completionHandler: { granted, _  in
            if granted {
                print("It's true")
                self.getSettings()
            }
        })
    }

    // текущие настройки
    func getSettings() {
        notificationsCenter.getNotificationSettings(completionHandler: { setting in
            print("Current settings: \(setting)")
        })
    }

    // расписание уведомлений
    func sheduleNotifications(notificationType: String) {
        let content = UNMutableNotificationContent()
        content.title = "Заметки"
        content.body = notificationType
        content.sound = UNNotificationSound.default
        content.badge = 1

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        let id = "Local Notification"
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        // вызовы уведомления в центре
        notificationsCenter.add(request) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Notes")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
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
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (
            UNNotificationPresentationOptions
        ) -> Void
    ) {
        completionHandler([.banner, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.identifier == "Local Notification" {
            print("Notification")
        }
        completionHandler()
    }
}
