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
    
    @IBAction func backBtnTapped(_ sender: UIBarButtonItem) {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

//extension SettingsTableViewController: UIPickerViewDelegate, UIPickerViewDataSource{
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return pickerSource.count
//    }
//
//    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
//        let attrTitle = NSAttributedString(string: pickerSource[row], attributes: [NSFontAttributeName: UIFont(name: StyleConstant.systemFontNameBold, size: 14.0), NSForegroundColorAttributeName: UIColor.black])
//        return attrTitle
//    }
//
//    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
//        return 40.0
//    }
//
//
//}
//
//
//



