//
//  MainViewController.swift
//  SmartBill
//
//  Created by Xie kesong on 11/25/16.
//  Copyright © 2016 ___KesongXie___. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    //unwind segue from setting
    @IBAction func backFromSettings(segue: UIStoryboardSegue){
        //do some configuration when return from settings
    }

    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var billTextField: UITextField!
    
    @IBOutlet weak var currencySymbol: UILabel!
    
    @IBOutlet weak var tipView: UIView!

    @IBOutlet weak var tipAmountLabel: UILabel!
    
    @IBOutlet weak var percentageLabel: UILabel!
    
    @IBOutlet weak var subtotalAfterLabel: UILabel!
    
    @IBOutlet weak var subTotalAfterStaticTextField: UITextField!
    
    @IBOutlet weak var subtotalBeforeLabel: UILabel!

    @IBOutlet weak var splitPickerView: UIPickerView!
    
    @IBOutlet weak var settingBtn: UIBarButtonItem!{
        didSet{
           settingBtn.stylized()
        }
    }
    
    var tipFactor: Double! = UserDefaults.getTipFactor(){
        didSet{
            //save to NSUserDefault
            UserDefaults.saveTipFactor(tipFactor)
        }
    }
    
    //max character input for bill text field
    let maxCharCount = 12
    
    // numerical value for tip
    var billAmount: Double = 0
    
    var tipAmount: String!{
        didSet{
            self.tipAmountLabel.text = tipAmount
        }
    }

    // possible state for the title
    enum titleStatus{
        case refreshing
        case initial
    }

    // A flag indicating whether the user is currently editing
    var calculating: Bool = false{
        didSet{
            delay(2.0, closure: {
                self.updateTitle(status: .initial)
            })
        }
    }
    
    
    // subtotal before the split
    var subtotalBefore: Double = 0{
        didSet{
            self.subtotalBeforeLabel?.text = getCurrenceStringFromAmount(self.subtotalBefore)
            updateSubtotalAfter()
        }
    }
    
    // subtotal after the split
    var subTotalAfter: Double = 0{
        didSet{
            self.subTotalAfterStaticTextField?.text = getCurrenceStringFromAmount(self.subTotalAfter)
        }
    }
    
    var splitCount: Int = 1 {
        didSet{
            self.updateSubtotalAfter()
        }
    }
    
    var splitPickerSource = initFriendSplitDataSoucre()
    
    
    // MARK: - slider properties
    @IBOutlet weak var leftPanel: UIView!
    
    @IBOutlet weak var overlayView: UIView!
    
    @IBAction func hamIconTapped(_ sender: UIBarButtonItem) {
        self.view.endEditing(true)
        self.toggleLeftPanel()
    }
    
    @IBOutlet weak var tipPercentPickerView: UIPickerView!
    
    @IBOutlet weak var weekDayLabel: UILabel!{
        didSet{
            self.weekDayLabel.text = Date().weekDayString.capitalized
        }
    }
    
    @IBOutlet weak var monthLabel: UILabel!{
        didSet{
            self.monthLabel.text = Date().monthString.capitalized
        }
    }
    
    @IBOutlet weak var dayLabel: UILabel!{
        didSet{
            self.dayLabel.text = Date().dayString
        }
    }
    
    enum LeftPanelStatus{
        case open
        case close
    }
    
    var leftPanelStatus = LeftPanelStatus.close
    
    var tipPercentPickerSource = [NSLocalizedString("Select Tip Percentage", comment:""), NSLocalizedString("None", comment:"tips selection none"), "5%", "10%","15%", "20%", "25%", "30%"]
    
    
    
    // MARK: - view conrtoller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // App setup and Update UI
        self.appInit()
        self.setScrollView()
        self.setPickerView()
        self.setCurrencySymbol()
        self.setNavigationBarUI()
        self.setBillTextField()
        self.setTipView()
        self.setSubtotalBefore()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.billTextField.becomeFirstResponder()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.leftPanelStatus == .open{
            //close it
            self.closeLeftPanel()
        }
    }
    
    func appWillTerminated(notification: Notification){
        //save bill amount to the user default with timestamp associated with it
        UserDefaults.saveBillAmountForNow(self.billTextField.text!)
    }
    
    
    /*
     * MARK: - App Init
     *       - UI Set Up
     *       - set up Slider View
     *       - keyboard set up
     *       - scrollView set up
     *       - set up pickeer view
     *       - set Bill Text Field
     *       - Update navigation bar UI
     *       - controller title update
     */
    
    /* Add tap gesture to the view  */
    func appInit(){
        self.restoreState()
        self.billTextField.becomeFirstResponder()
        NotificationCenter.default.addObserver(self, selector: #selector(self.appWillTerminated(notification:)), name: NotificationName.AppWillTerminate, object: nil)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.viewTapped))
        self.view.addGestureRecognizer(tapGesture)
    }
  
    func setScrollView(){
        self.scrollView.alwaysBounceVertical = true
        self.scrollView.delegate = self
    }
    
    func setPickerView(){
        self.splitPickerView.delegate = self
        self.splitPickerView.dataSource = self
        self.tipPercentPickerView.delegate = self
        self.tipPercentPickerView.dataSource = self
    }
    
    func setCurrencySymbol(){
        self.currencySymbol.text = getCurrencySymbol()
    }
    
    
    func setBillTextField(){
        self.billTextField.delegate = self
        self.billTextField.addTarget(self, action: #selector(self.billTextFieldTextDidChange), for: UIControlEvents.editingChanged)
        if let placeHolder = self.billTextField.placeholder{
            self.billTextField.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSForegroundColorAttributeName: UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 0.6)])
        }
    }
    
    func setNavigationBarUI(){
        self.navigationController?.navigationBar.barTintColor = StyleConstant.NavigationBar.backgroundColor
        self.navigationController?.navigationBar.titleTextAttributes = StyleConstant.NavigationBar.titleTextAttribute
        self.navigationController?.navigationBar.isTranslucent = StyleConstant.NavigationBar.translucent
    }
    
    func updateTitle(status: titleStatus){
        switch status{
        case .initial:
            self.title = AppName
        case .refreshing:
            self.title = NSLocalizedString("CALCULATING...", comment: "The title for the view controller")
        }
    }
    
    /* billTextField resign first responder, Hide the keyboard */
    func viewTapped(){
        self.billTextField.resignFirstResponder()
    }


    
    /* MARK: - Set data model
     *       - set tip amount
     *       - set tip factor
     *       - set subtotal before the split
     *       - set subtotal after the split */
    func setTipView(){
        self.tipAmount = getCurrenceStringFromAmount(billAmount * tipFactor)
        self.percentageLabel.text = "\(tipFactor * 100)"
    }
    
    /* This function is responsible for updating the subtotal, any subsequent 
     * UI will be adjusted correspondingly */
    func setSubtotalBefore(){
        self.subtotalBefore = billAmount * (1 + tipFactor)
    }

    
    func updateSubtotalAfter(){
        self.subTotalAfter = subtotalBefore / Double(self.splitCount)
    }
    
    
    // MARK: -Left panel control
    func openLeftPanel(){
        UIView.animate(withDuration: 0.3,
        animations: {
        self.leftPanel.frame.origin.x = 0
        self.overlayView.alpha = 0.6
        },
        completion:{
            completed in
            if completed{
                self.leftPanelStatus = .open
            }
            self.tipPercentPickerView.selectRow(rowForPickerFromTipFactor(self.tipFactor), inComponent: 0, animated: true)
        })
    }
    
    func closeLeftPanel(){
        UIView.animate(withDuration: 0.3,
        animations: {
            self.leftPanel.frame.origin.x = -self.leftPanel.frame.size.width
            self.overlayView.alpha = 0
        },
        completion:{
            completed in
                if completed{
                self.setTipView()
                self.percentageLabel?.text = String(self.tipFactor * 100)
                self.setSubtotalBefore()
            }
        })
        self.leftPanelStatus = .close
    }
    
    func toggleLeftPanel(){
        switch self.leftPanelStatus{
        case .close:
            //open
            delay(0.5, closure: {
                self.openLeftPanel()
            })
        case .open:
            //close
            self.closeLeftPanel()
        }
    }
    
    // MARK: - Bill text field control event
    func billTextFieldTextDidChange(){
        if let billString = self.billTextField.text{
            calculating = true
            updateTitle(status: .refreshing)
            let noneCurrencyFormatter = NumberFormatter()
            if let num = noneCurrencyFormatter.number(from: billString) as? Double{
                self.billAmount = num
            }else{
                self.billAmount = 0
            }
            self.setTipView()
            self.setSubtotalBefore()
        }
    }
    

    /*  Restore the bill amount information if the user reopen the app again within
     *  a certain time */
    func restoreState(){
        if let billAmountInfo = UserDefaults.getBillAmount(){
            //check whether the old bill amount should be used for display or not
            if let date = billAmountInfo["timestamp"] as? Date{
                let minutesAgo = -date.timeIntervalSinceNow / 60
                if minutesAgo <= 30{
                    //restore
                    if let billString = billAmountInfo["amount"] as? String{
                        if let amount = Double(billString){
                            self.billAmount = amount
                            self.billTextField.text = billString
                        }
                    }
                }else{
                    //clear the old data
                    UserDefaults.clearBillAmountHistory()
                }
            }
        }
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.view.endEditing(true)
    }
    
}


// MARK: - UITextFieldDelegate
extension MainViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let billString = textField.text{
            if string == ""{
                //delete button pressed
                return true
            }else if billString.characters.count == 1 && billString.characters.first == "0" && string != "."{
                //replace the leading 0
                textField.text = ""
            }else if billString.characters.count >= self.maxCharCount{
                return false
            }else if string == "."{
                //make sure the input is valid
                if textField.text!.contains("."){
                    return false
                }
            }
        }
        return true
    }
}

// MARK: - UIScrollViewDelegate
extension MainViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < -40{
            self.billTextField.resignFirstResponder()
        }
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource
 extension MainViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerView == self.splitPickerView ? splitPickerSource.count : tipPercentPickerSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var attrTitle:NSAttributedString?
        if pickerView == self.splitPickerView{
            attrTitle = NSAttributedString(string: splitPickerSource[row], attributes: StyleConstant.SplitPikcerView.titleAttribute)
        }else{
            attrTitle = NSAttributedString(string: tipPercentPickerSource[row], attributes: StyleConstant.TipPercentPickerView.titleAttribute)
        }
        
        return attrTitle
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40.0
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == self.splitPickerView{
            self.splitCount = 1 + row
        }else{
            self.tipFactor = 0
            if row >= 2{
                self.tipFactor = Double((row - 1)) * 0.05
            }
        }
    }
}


