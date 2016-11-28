//
//  MainViewController.swift
//  SmartBill
//
//  Created by Xie kesong on 11/25/16.
//  Copyright © 2016 ___KesongXie___. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

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
    
    var tipFactor: Double! = 0
    
    //max character input for bill text field
    let maxCharCount = 12
    
    // numerical value for tip
    var billAmount: Double = 0
    
    var tipAmount: String!{
        didSet{
            self.tipAmountLabel.text = tipAmount
        }
    }
    
    var calculating: Bool = false{
        didSet{
            delay(2.0, closure: {
                self.updateTitle(status: .initial)
            })
        }
    }
    
    var subTotalAfter: Double = 0{
        didSet{
            self.subTotalAfterStaticTextField?.text = getCurrenceStringFromAmount(self.subTotalAfter)
        }
    }
    
    var subtotalBefore: Double = 0{
        didSet{
            self.subtotalBeforeLabel?.text = getCurrenceStringFromAmount(self.subtotalBefore)
            updateSubtotalAfter()
        }
    }
    
    var splitCount: Int = 1 {
        didSet{
            self.updateSubtotalAfter()
        }
    }
    
    enum titleStatus{
        case refreshing
        case initial
    }
    
    var splitPickerSource = initFriendSplitDataSoucre()
    
    /*
     * MARK: - slider properties
     */
    @IBOutlet weak var leftPanel: UIView!
    
    @IBOutlet weak var overlayView: UIView!
    
    
    @IBAction func hamIconTapped(_ sender: UIBarButtonItem) {
        self.view.endEditing(true)
        self.toggleLeftPanel()
    }
    
    @IBOutlet weak var tipPercentPickerView: UIPickerView!
    
    @IBOutlet weak var weekDayLabel: UILabel!{
        didSet{
            self.weekDayLabel.text = Date().weekDayString.uppercased()
        }
    }
    
    @IBOutlet weak var monthLabel: UILabel!{
        didSet{
            self.monthLabel.text = Date().monthString.uppercased()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Update UI
        setView()
        setScrollView()
        setPickerView()
        setCurrencySymbol()
        setNavigationBarUI()
        setBillTextField()
        setTipFactor()
        setTipView()
        setSubtotalBefore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.billTextField.becomeFirstResponder()
    }
    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
       
    /*
     * MARK: - UI Set Up
     *       - view set up
     *       - set up Slider View
     *       - keyboard set up
     *       - scrollView set up
     *       - set up pickeer view
     *       - set Bill Text Field
     *       - Update navigation bar UI
     *       - controller title update
     */
    
    /*
        Add tap gesture to the view
     */
    func setView(){
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
      //  self.billTextField.becomeFirstResponder()
        self.billTextField.addTarget(self, action: #selector(self.billTextFieldTextDidChange), for: UIControlEvents.editingChanged)
        if let placeHolder = self.billTextField.placeholder{
            self.billTextField.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSForegroundColorAttributeName: UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 0.6)])
        }
    }
    
    func setNavigationBarUI(){
        self.navigationController?.navigationBar.barTintColor = StyleConstant.NavigationBar.backgroundColor
        self.navigationController?.navigationBar.titleTextAttributes = StyleConstant.NavigationBar.titleTextAttribute
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    func updateTitle(status: titleStatus){
        switch status{
        case .initial:
            self.title = AppName
        case .refreshing:
            self.title = NSLocalizedString("CALCULATING...", comment: "The title for the view controller")
        }
    }

    /*
     * MARK: - Set data model
     *       - set tip amount
     *       - set tip factor
     *       - set subtotal before the split
     *       - set subtotal after the split
     *       - selector when view is tapped
     */
    func setTipView(){
        self.tipAmount = getCurrenceStringFromAmount(billAmount * tipFactor)
        self.percentageLabel.text = "\(tipFactor * 100)"
    }
    
    func setTipFactor(){
        self.tipFactor = 0.15
    }
   
    func setSubtotalBefore(){
        self.subtotalBefore = billAmount * (1 + tipFactor)
    }

    
    func updateSubtotalAfter(){
        self.subTotalAfter = subtotalBefore / Double(self.splitCount)
    }
    
    
    func viewTapped(){
        view.endEditing(true)
    }
    
    func toggleLeftPanel(){
        switch self.leftPanelStatus{
        case .close:
            //open
            UIView.animate(withDuration: 0.3, animations: {
                self.leftPanel.frame.origin.x = 0
                self.overlayView.alpha = 0.6
            })
            self.leftPanelStatus = .open
        case .open:
            //close
            UIView.animate(withDuration: 0.3, animations: {
                self.leftPanel.frame.origin.x = -self.leftPanel.frame.size.width
                self.overlayView.alpha = 0
                }, completion:{
                    completed in
                    if completed{
                        self.setTipView()
                        self.percentageLabel?.text = String(self.tipFactor * 100)
                        self.setSubtotalBefore()
                    }
            })
            self.leftPanelStatus = .close
        }
    }

    
    /* MARK: - Bill text field control event
     */
 
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
            setTipView()
            setSubtotalBefore()
        }
    }
    
    
    // MARK: - Navigation

     //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        view.endEditing(true)
    }
    
}

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

extension MainViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < -40{
            self.billTextField.resignFirstResponder()
        }
    }
}

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
            attrTitle = NSAttributedString(string: splitPickerSource[row], attributes: [NSFontAttributeName: UIFont(name: StyleConstant.systemFontNameBold, size: 14.0), NSForegroundColorAttributeName: UIColor.black])
        }else{
             attrTitle = NSAttributedString(string: tipPercentPickerSource[row], attributes: [NSFontAttributeName: UIFont(name: StyleConstant.systemFontNameBold, size: 14.0), NSForegroundColorAttributeName: UIColor.white])
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



