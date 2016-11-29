//
//  Helper.swift
//  SmartBill
//
//  Created by Xie kesong on 11/27/16.
//  Copyright © 2016 ___KesongXie___. All rights reserved.
//

import Foundation

func delay(_ delay:Double, closure:@escaping ()->()) {
    let when = DispatchTime.now() + delay
    DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
}

func getCurrencySymbol() -> String{
    let currencyFormatter = NumberFormatter()
    return currencyFormatter.currencySymbol
}


func getCurrenceStringFromAmount(_ amount: Double) -> String?{
    let currencyFormatter = NumberFormatter()
    currencyFormatter.numberStyle = .currency
    return currencyFormatter.string(from: amount as NSNumber)
}

func initFriendSplitDataSoucre() -> [String]{
    //["Share Bill With", "1 Friend", "2 Friends"]
    var dataSource = [String]()
    for i in 0...maxSplitCount{
        switch i{
        case 0:
            dataSource.append(NSLocalizedString("Share Bill With", comment: ""))
        case 1:
            dataSource.append("1 \(NSLocalizedString("Friend", comment: "How many friends"))")
        default:
            dataSource.append("\(i) \(NSLocalizedString("Friends", comment: "How many friends"))")
        }
    }
    return dataSource
}


// Save the tip factor to the NSUserDefault
func saveTipFactor(_ tipFactor: Double){
    UserDefaults.standard.set(tipFactor, forKey: tipFactorKey)
}

// Get the tip factor from the NSUserDefault
func getTipFactor() -> Double{
    return UserDefaults.standard.double(forKey: tipFactorKey)
}

func tipFactorFromPickerRowIndex(_ row: Int) -> Double{
    return Double((row - 1)) * 0.05
}

func rowForPickerFromTipFactor(_ tipFactor: Double) -> Int{
    return Int(tipFactor / 0.05) + 1
}













