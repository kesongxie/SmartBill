//
//  SettingsViewController.swift
//  SmartBill
//
//  Created by Xie kesong on 11/27/16.
//  Copyright © 2016 ___KesongXie___. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    
    @IBOutlet weak var backBtn: UIBarButtonItem!{
        didSet{
            backBtn.stylized()
        }
    }
    
    @IBOutlet weak var nightModeView: UIView!{
        didSet{
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.nightModeViewTapped(gesture:)))
            nightModeView.addGestureRecognizer(tapGesture)
        }
    }
    
    @IBOutlet weak var dayModeView: UIView!{
        didSet{
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dayModeViewTapped(gesture:)))
            dayModeView.addGestureRecognizer(tapGesture)
        }
    }

       
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func nightModeViewTapped(gesture: UIGestureRecognizer){
        //post notification
        let info = [NotificationInfoKey.themeState: ThemeState.night]
        let modeChangedNotification = Notification(name: NotificationName.ModeChange, object: nil, userInfo: info)
        NotificationCenter.default.post(modeChangedNotification)
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    func dayModeViewTapped(gesture: UIGestureRecognizer){
        //post notification
        let info = [NotificationInfoKey.themeState: ThemeState.day]
        let modeChangedNotification = Notification(name: NotificationName.ModeChange, object: nil, userInfo: info)
        NotificationCenter.default.post(modeChangedNotification)
         let _ = self.navigationController?.popViewController(animated: true)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}



