//
//  NotificationName.swift
//  SmartBill
//
//  Created by Xie kesong on 11/29/16.
//  Copyright © 2016 ___KesongXie___. All rights reserved.
//

import UIKit
struct NotificationName{
    static let AppWillTerminate = fromString(notificationName: "AppWillTerminate")
    static let ModeChange = fromString(notificationName: "ModeChange")
    static func fromString(notificationName name: String) -> NSNotification.Name{
        return Notification.Name.init(rawValue: name)
    }
    
}
