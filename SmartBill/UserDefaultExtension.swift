//
//  UserDefaultExtension.swift
//  SmartBill
//
//  Created by Xie kesong on 11/29/16.
//  Copyright © 2016 ___KesongXie___. All rights reserved.
//

import Foundation

extension UserDefaults{
    
    // Save the bill amount to the NSUserDefault
    static func saveBillAmountForNow(_ amount: String){
        let data: [String: Any] = [BillAmountInfoAmountKey: amount, BillAmountInfoDateKey: NSDate()]
        UserDefaults.standard.set(data, forKey: UserDefaultKey.billAmount)
    }
    
    // Get the bill amount from the NSUserDefault
    static func getBillAmount() -> [String: Any]?{
        return UserDefaults.standard.dictionary(forKey: UserDefaultKey.billAmount)
    }
    
    static func clearBillAmountHistory(){
        UserDefaults.standard.removeObject(forKey: UserDefaultKey.billAmount)
    }
    
    // Save the tip factor to the NSUserDefault
    static func saveTipFactor(_ tipFactor: Double){
        UserDefaults.standard.set(tipFactor, forKey: UserDefaultKey.tipFactor)
    }
    
    // Get the tip factor from the NSUserDefault
    static func getTipFactor() -> Double{
        return UserDefaults.standard.double(forKey: UserDefaultKey.tipFactor)
    }
    
    static func getTheme() -> Theme{
        if let stateRawValue = UserDefaults.standard.object(forKey: UserDefaultKey.theme) as? Int{
            if let theme = ThemeState(rawValue: stateRawValue){
                return theme == .day ? dayTheme : nightTheme
            }
        }
        return nightTheme
    }
    
    static func saveTheme(_ state: ThemeState){
        UserDefaults.standard.set(state.rawValue, forKey: UserDefaultKey.theme)
    }
}
