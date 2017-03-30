//
//  HomeScreenViewController.swift
//  LCTApp
//
//  Created by Suraj MAC2 on 3/19/16.
//  Copyright © 2016 supaint. All rights reserved.
//

import UIKit
import Alamofire


class HomeScreenViewController: UIViewController,UITextFieldDelegate {

    
//TODO: - Generals
    let delObj = UIApplication.sharedApplication().delegate as! AppDelegate
    var is_autologin : Bool = Bool()
    let defaults =  NSUserDefaults.standardUserDefaults()
    let cust : ViewController = ViewController()
    
    
    var fidArray : [String] = []
    var memArray : [String] = []
    var tempFidArray : [String] = []
    var tempMemArray : [String] = []
    
    var globalTag : Int = Int()
    var  tempfid : String = String()
    var tempmid : String = String()
    
//TODO: - Controlls
    
    @IBOutlet weak var containerView: UIView!
    
    //UIImage
    @IBOutlet weak var imgBottom: UIImageView!
    @IBOutlet weak var imgBG: UIImageView!
    //UILabel
    @IBOutlet weak var lblFIDTitle: UILabel!
    @IBOutlet weak var lblMemNoTitle: UILabel!
    
    //UITextField
    @IBOutlet weak var txtFund1: UITextField!
    @IBOutlet weak var txtFund2: UITextField!    
    @IBOutlet weak var txtFund4: UITextField!
    @IBOutlet weak var txtFund3: UITextField!
    @IBOutlet weak var txtFund5: UITextField!
    @IBOutlet weak var txtFund6: UITextField!
    @IBOutlet weak var txtFund7: UITextField!
    @IBOutlet weak var txtFund8: UITextField!
    @IBOutlet weak var txtFund9: UITextField!
    @IBOutlet weak var txtFund10: UITextField!
    
    //Member No
    
    @IBOutlet weak var txtMemb1: UITextField!
    @IBOutlet weak var txtMemb2: UITextField!
    @IBOutlet weak var txtMemb3: UITextField!
    
    //Button
    
    @IBOutlet weak var btnSubmitOutlet: UIButton!
    
    
//TODO: - Let's Play
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.        
       
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)        
        self.btnSubmitOutlet.layer.cornerRadius = delObj.roundedCorner
        self.txtFund1.layer.borderWidth = 1.0
        self.txtFund1.layer.borderColor = UIColor.whiteColor().CGColor
        self.txtFund2.layer.borderWidth = 1.0
        self.txtFund2.layer.borderColor = UIColor.whiteColor().CGColor
        self.txtFund3.layer.borderWidth = 1.0
        self.txtFund3.layer.borderColor = UIColor.whiteColor().CGColor
        self.txtFund4.layer.borderWidth = 1.0
        self.txtFund4.layer.borderColor = UIColor.whiteColor().CGColor
        self.txtFund5.layer.borderWidth = 1.0
        self.txtFund5.layer.borderColor = UIColor.whiteColor().CGColor
        self.txtFund6.layer.borderWidth = 1.0
        self.txtFund6.layer.borderColor = UIColor.whiteColor().CGColor
        self.txtFund7.layer.borderWidth = 1.0
        self.txtFund7.layer.borderColor = UIColor.whiteColor().CGColor
        self.txtFund8.layer.borderWidth = 1.0
        self.txtFund8.layer.borderColor = UIColor.whiteColor().CGColor
        self.txtFund9.layer.borderWidth = 1.0
        self.txtFund9.layer.borderColor = UIColor.whiteColor().CGColor
        self.txtFund10.layer.borderWidth = 1.0
        self.txtFund10.layer.borderColor = UIColor.whiteColor().CGColor
        self.txtMemb3.layer.borderWidth = 1.0
        self.txtMemb3.layer.borderColor = UIColor.whiteColor().CGColor
        self.txtMemb1.layer.borderWidth = 1.0
        self.txtMemb1.layer.borderColor = UIColor.whiteColor().CGColor
        self.txtMemb2.layer.borderWidth = 1.0
        self.txtMemb2.layer.borderColor = UIColor.whiteColor().CGColor
        
        
        //Device height
       if(delObj.deviceHeight == 667){
            imgBG.image = UIImage(named: "iPhone6_bg.png")
             imgBottom.image = UIImage(named: "iPhone6_bot.png")
        }else if(delObj.deviceHeight == 736){
            imgBG.image = UIImage(named: "iPhone6_plus_bg.png")
             imgBottom.image = UIImage(named: "iPhone6_plus_bot.png")
       }else if(delObj.deviceHeight == 568){
            imgBG.image = UIImage(named: "iPhone5_bg.png")
            imgBottom.image = UIImage(named: "iPhone5_bot.png")
       }else{
            imgBG.image = UIImage(named: "iPhone5_bg.png")
            imgBottom.image = UIImage(named: "iPhone4_bot.png")
        }
        
        //Clear array
        fidArray.removeAll(keepCapacity: false)
        memArray.removeAll(keepCapacity: false)

        //Check For Defaults
        if(defaults.valueForKey("fidArray") != nil && defaults.valueForKey("memArray") != nil){
            tempFidArray = defaults.valueForKey("fidArray") as! [String]
            tempMemArray = defaults.valueForKey("memArray") as! [String]
            assignValueToFields()
        }else{
            clearAll()
            print("fidArray and MemArray is nil")
        }
        
        
        //Check for autologin
        if(defaults.valueForKey("is_autologin") != nil){
             is_autologin = defaults.valueForKey("is_autologin") as! Bool
        }else{
            defaults.setValue(false, forKey: "is_autologin")
            defaults.synchronize()
        }
        is_autologin = defaults.valueForKey("is_autologin") as! Bool
        
        if(is_autologin){
            print("is_autologin")
            
            let loginType = defaults.valueForKey("loginType") as! String
            if(loginType == "greek"){
                let confVC = self.storyboard?.instantiateViewControllerWithIdentifier("idConfirmationViewController") as! ConfirmationViewController
                self.navigationController?.pushViewController(confVC, animated: true)
                
            }else if(loginType == "school"){
                let confVC = self.storyboard?.instantiateViewControllerWithIdentifier("idSchoolConfirmationViewController") as! SchoolConfirmationViewController
                self.navigationController?.pushViewController(confVC, animated: true)
                
            }
            
            
           
            
        }else{
            
            print("is_autologin false")
        }
       
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        UIView.animateWithDuration(0.9, animations: { () -> Void in
            self.lblFIDTitle.transform = CGAffineTransformMakeScale(0.8, 0.8)
            self.lblMemNoTitle.transform = CGAffineTransformMakeScale(0.8, 0.8)
            }) { (Value:Bool) -> Void in
                
                
                UIView.animateWithDuration(0.6, animations: { () -> Void in
                    self.lblFIDTitle.transform = CGAffineTransformMakeScale(1.1, 1.1)
                    self.lblMemNoTitle.transform = CGAffineTransformMakeScale(1.1, 1.1)
                    
                    }, completion: { (Value:Bool) -> Void in
                        self.lblFIDTitle.transform = CGAffineTransformIdentity
                        self.lblMemNoTitle.transform = CGAffineTransformIdentity
                })
               
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//TODO: - API / Web service call
    
    func sendUserDetails(fid:String,mid:String){
        
       
        
        //Progress activity loaded
        SVProgressHUD.showWithStatus("Loading...")
        
        var loginType : String = String()
        if(fid.hasPrefix("1")){
            loginType = "greek"
        }else{
             loginType = "school"
        }
        
        print(loginType)
        // Correct url and username/password
        //http:/supraint.com/works/lct/html/webservices
        //http:/life-changes-today.com/webservices/
        Alamofire.Manager.sharedInstance.request(.POST, "http://life-changes-today.com/webservices/greek_iosresponce.php", parameters: ["FIDNO":fid,"MEMNO":mid,"flag":"searchfid","loginType":loginType]).responseJSON{
            response in
            print(response.result.value)
            if(response.result.isSuccess){
                
                let outJSON = JSON(response.result.value!)
                print("outJSON:\(outJSON)")
                if(outJSON["msgflag"].stringValue == "Success"){
                    
                    let dict = ["chapter":outJSON["chapter"].stringValue,
                        "college":outJSON["college"].stringValue,
                        "membername":outJSON["membername"].stringValue,
                        "msgflag":outJSON["msgflag"].stringValue,
                        "sorority":outJSON["sorority"].stringValue,
                        "strfid":outJSON["strfid"].stringValue,
                        "labeltitle":outJSON["labeltitle"].stringValue,
                     "strmem":outJSON["strmem"].stringValue]
                    
                    self.defaults.setValue(loginType, forKey: "loginType")
                    self.defaults.setValue(dict, forKey: "AppUserDetails")
                    self.defaults.synchronize()
                    
                    SVProgressHUD.dismiss()
                    
                    if(loginType == "greek"){
                        let infoVC = self.storyboard?.instantiateViewControllerWithIdentifier("idInformationScreenViewController") as! InformationScreenViewController
                        self.navigationController?.pushViewController(infoVC, animated: true)

                    }else if(loginType == "school"){
                        let infoVC = self.storyboard?.instantiateViewControllerWithIdentifier("idSchoolInformationViewController") as! SchoolInformationViewController
                        self.navigationController?.pushViewController(infoVC, animated: true)

                    }
                    
                }else{
                    SVProgressHUD.dismiss()
                    self.delObj.displayAlert("LCT App", msg:outJSON["errormsg"].stringValue )
                }
                
                
            }else{
                SVProgressHUD.dismiss()
                self.delObj.displayAlert("LCT App", msg: "Please check internet connection")
            }
            
            
        }
        
        
    }
    
    func clearAll(){
        
        for view in self.view.subviews {
            if let textField = view as? UITextField {
                textField.text = ""
            }
        }
        
        for case let textField as UITextField in self.containerView.subviews {
            textField.text = ""
        }
        
    }
    
    func assignValueToFields(){
        txtFund1.text = tempFidArray[0]
        txtFund2.text = tempFidArray[1]
        txtFund3.text = tempFidArray[2]
        txtFund4.text = tempFidArray[3]
        txtFund5.text = tempFidArray[4]
        txtFund6.text = tempFidArray[5]
        txtFund7.text = tempFidArray[6]
        txtFund8.text = tempFidArray[7]
        txtFund9.text = tempFidArray[8]
        txtFund10.text = tempFidArray[9]
        
        txtMemb1.text = tempMemArray[0]
        txtMemb2.text = tempMemArray[1]
        txtMemb3.text = tempMemArray[2]
        
    }
    
    
    
    
    
    
//TODO: - UITextFieldDelegate Methods
//
//    override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
//        
//       return (action != "paste:")
//    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
    
        if (textField == txtFund1){
            txtFund1.becomeFirstResponder()
        }else if(textField == txtFund2){
            txtFund2.becomeFirstResponder()
        }else if(textField == txtFund3){
            txtFund3.becomeFirstResponder()
        }else if(textField == txtFund4){
            txtFund4.becomeFirstResponder()
        }else if(textField == txtFund5){
            txtFund5.becomeFirstResponder()
        }else if(textField == txtFund6){
            txtFund6.becomeFirstResponder()
        }else if(textField == txtFund7){
            txtFund7.becomeFirstResponder()
        }else if(textField == txtFund8){
            txtFund8.becomeFirstResponder()
        }else if(textField == txtFund9){
            txtFund9.becomeFirstResponder()
        }else if(textField == txtFund10){
            txtFund10.becomeFirstResponder()
        }
        
        
        return false
    }
    
    func keyboardDidShow(notification : NSNotification){
        
        //return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField){
        print("begin....::\(textField.tag)")
        globalTag = textField.tag
        
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        //Making A toolbar
        let keyboardDoneButtonShow = UIToolbar(frame: CGRectMake(0, (self.view.frame.size.height - (self.view.frame.size.height/17)),  self.view.frame.size.width, self.view.frame.size.height/17))
        //Setting the style for the toolbar
        keyboardDoneButtonShow.barStyle = UIBarStyle .BlackTranslucent
        //Making the done button and calling the textFieldShouldReturn native method for hidding the keyboard.
        let doneButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Done, target: self, action: #selector(UITextFieldDelegate.textFieldShouldClear(_:)))
        doneButton.tintColor = UIColor.whiteColor()
        //Calculating the flexible Space.
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        //Setting the color of the button.
        //item.tintColor = UIColor.yellowColor()
        //Making an object using the button and space for the toolbar
        let toolbarButton = [flexSpace,doneButton]
        //Adding the object for toolbar to the toolbar itself
        keyboardDoneButtonShow.setItems(toolbarButton, animated: false)
        //Now adding the complete thing against the desired textfield
       textField.inputAccessoryView = keyboardDoneButtonShow
       // self.view.addSubview(keyboardDoneButtonShow)
        return true
        
    }
    
    func textFieldShouldClear(textField: UITextField) -> Bool{
        print("clear....\(textField.tag)")
        if(globalTag == txtFund10.tag){
            txtFund10.text = ""
            self.performSelector(#selector(HomeScreenViewController.setNextResponder(_:)), withObject: txtFund9, afterDelay: 0.1)
        }else if(globalTag == txtFund9.tag){
            txtFund9.text = ""
            self.performSelector(#selector(HomeScreenViewController.setNextResponder(_:)), withObject: txtFund8, afterDelay: 0.1)
        }else if(globalTag == txtFund8.tag){
            txtFund8.text = ""
            self.performSelector(#selector(HomeScreenViewController.setNextResponder(_:)), withObject: txtFund7, afterDelay: 0.1)
        }else if(globalTag == txtFund7.tag){
            txtFund7.text = ""
            self.performSelector(#selector(HomeScreenViewController.setNextResponder(_:)), withObject: txtFund6, afterDelay: 0.1)
        }else if(globalTag == txtFund6.tag){
            txtFund6.text = ""
            self.performSelector(#selector(HomeScreenViewController.setNextResponder(_:)), withObject: txtFund5, afterDelay: 0.1)
        }else if(globalTag == txtFund5.tag){
            txtFund5.text = ""
            self.performSelector(#selector(HomeScreenViewController.setNextResponder(_:)), withObject: txtFund4, afterDelay: 0.1)
        }else if(globalTag == txtFund4.tag){
            txtFund4.text = ""
            self.performSelector(#selector(HomeScreenViewController.setNextResponder(_:)), withObject: txtFund3, afterDelay: 0.1)
        }else if(globalTag == txtFund3.tag){
            txtFund3.text = ""
            self.performSelector(#selector(HomeScreenViewController.setNextResponder(_:)), withObject: txtFund2, afterDelay: 0.1)
        }else if(globalTag == txtFund2.tag){
            txtFund2.text = ""
            self.performSelector(#selector(HomeScreenViewController.setNextResponder(_:)), withObject: txtFund1, afterDelay: 0.1)
        }else if(globalTag == txtFund1.tag){
            txtFund1.text = ""
            txtFund1.resignFirstResponder()  //Very First position Fundraiser
        }
        else if(globalTag == txtMemb3.tag){
            txtMemb3.text = ""
            self.performSelector(#selector(HomeScreenViewController.setNextResponder(_:)), withObject: txtMemb2, afterDelay: 0.1)
        }else if(globalTag == txtMemb2.tag){
              txtMemb2.text = ""
            self.performSelector(#selector(HomeScreenViewController.setNextResponder(_:)), withObject: txtMemb1, afterDelay: 0.1)
        }else if(globalTag == txtMemb1.tag){
              txtMemb1.text = ""
            self.performSelector(#selector(HomeScreenViewController.setNextResponder(_:)), withObject: txtFund10, afterDelay: 0.1)  //Very First position Member
            
            //txtMemb1.resignFirstResponder()
        }
        if(globalTag == txtMemb1.tag || globalTag == txtMemb2.tag || globalTag == txtMemb3.tag){
         //   memArray.removeLast()
        }else{
         //   fidArray.removeLast()
        }
        
       // print("-:\(fidArray)")
       // print("mem-: \(memArray)")
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool{
        
        var shouldProcess = false //default to reject
        var shouldMoveToNextField = false //default to remaining on the current field
        
        let insertStringLength : Int = string.characters.count
        
        if (range.length == 1 && string.isEmpty){
            print("Used Backspace")
        }
        
      /*  if(range.length == 1 && range.location == 0){
            print("Backspace is Hit")
        }
        
        if (string.characters.count==0) { //Delete any cases
            if(range.length > 1){
                print("Delete whole word")
                //Delete whole word
            }
            else if(range.length == 1){
                print("Delete single letter")
                //Delete single letter
            }
            else if(range.length == 0){
                print("Tap delete key when textField empty")
                //Tap delete key when textField empty
            }  
        }
        
        */
        
        if(insertStringLength == 0){
            //backspace press
           textField.becomeFirstResponder()
            shouldProcess = true //Process if the backspace character was pressed
            
        }else{
            if(textField.text?.characters.count == 0){
                shouldProcess = true //Process if there is only 1 character right now
            }
        }
        
        if(shouldProcess){
            //grab a mutable copy of what's currently in the UITextField
            let mstring : NSMutableString = NSMutableString(UTF8String: textField.text!)!
            
            if(mstring.length == 0){
                mstring.appendString(string)
                shouldMoveToNextField = true
            }else{
                //adding a char or deleting?
                if(insertStringLength > 0){
                    mstring.insertString(string, atIndex: range.location)
                }else{
                    //delete case - the length of replacement string is zero for a delete
                    
                    //this goes to previous field as you backspace through them, so you don't have to tap into them individually
                    
                    if(textField == txtFund10){
                        self.performSelector(#selector(HomeScreenViewController.setNextResponder(_:)), withObject: txtFund9, afterDelay: 0.1)
                    }else if(textField == txtFund9){
                        self.performSelector(#selector(HomeScreenViewController.setNextResponder(_:)), withObject: txtFund8, afterDelay: 0.1)
                    }else if(textField == txtFund8){
                        self.performSelector(#selector(HomeScreenViewController.setNextResponder(_:)), withObject: txtFund7, afterDelay: 0.1)
                    }else if(textField == txtFund7){
                        self.performSelector(#selector(HomeScreenViewController.setNextResponder(_:)), withObject: txtFund6, afterDelay: 0.1)
                    }else if(textField == txtFund6){
                        self.performSelector(#selector(HomeScreenViewController.setNextResponder(_:)), withObject: txtFund5, afterDelay: 0.1)
                    }else if(textField == txtFund5){
                        self.performSelector(#selector(HomeScreenViewController.setNextResponder(_:)), withObject: txtFund4, afterDelay: 0.1)
                    }else if(textField == txtFund4){
                        self.performSelector(#selector(HomeScreenViewController.setNextResponder(_:)), withObject: txtFund3, afterDelay: 0.1)
                    }else if(textField == txtFund3){
                        self.performSelector(#selector(HomeScreenViewController.setNextResponder(_:)), withObject: txtFund2, afterDelay: 0.1)
                    }else if(textField == txtFund2){
                        self.performSelector(#selector(HomeScreenViewController.setNextResponder(_:)), withObject: txtFund1, afterDelay: 0.1)
                    }else if(textField == txtFund1){
                        txtFund1.resignFirstResponder()  //Very First position Fundraiser
                    }else if(textField == txtMemb3){
                        self.performSelector(#selector(HomeScreenViewController.setNextResponder(_:)), withObject: txtMemb2, afterDelay: 0.1)
                    }else if(textField == txtMemb2){
                        self.performSelector(#selector(HomeScreenViewController.setNextResponder(_:)), withObject: txtMemb1, afterDelay: 0.1)
                    }else if(textField == txtMemb1){
                        self.performSelector(#selector(HomeScreenViewController.setNextResponder(_:)), withObject: txtFund10, afterDelay: 0.1)  //Very First position Member

                        //txtMemb1.resignFirstResponder() 
                    }
                    
                    mstring.deleteCharactersInRange(range)
                    if(textField == txtMemb1 || textField == txtMemb2 || textField == txtMemb3){
                   //     memArray.removeLast()
                    }else{
                    //    fidArray.removeLast()
                    }
                    
                }
            }
            
            //set the text now
            textField.text = mstring as String
            //mstring.release
          //  print("-:\(fidArray)")
          //   print("mem-: \(memArray)")
            
        }else{
            shouldMoveToNextField = true
        }
        if (shouldMoveToNextField) {
            //
            //MOVE TO NEXT INPUT FIELD HERE
            //
            if(textField == txtFund1){
                self.performSelector(#selector(HomeScreenViewController.setNextResponder(_:)), withObject: txtFund2, afterDelay: 0.1)
            }else if(textField == txtFund2){
                self.performSelector(#selector(HomeScreenViewController.setNextResponder(_:)), withObject: txtFund3, afterDelay: 0.1)
            }else if(textField == txtFund3){
                self.performSelector(#selector(HomeScreenViewController.setNextResponder(_:)), withObject: txtFund4, afterDelay: 0.1)
            }else if(textField == txtFund4){
                self.performSelector(#selector(HomeScreenViewController.setNextResponder(_:)), withObject: txtFund5, afterDelay: 0.1)
            }else if(textField == txtFund5){
                self.performSelector(#selector(HomeScreenViewController.setNextResponder(_:)), withObject: txtFund6, afterDelay: 0.1)
            }else if(textField == txtFund6){
                self.performSelector(#selector(HomeScreenViewController.setNextResponder(_:)), withObject: txtFund7, afterDelay: 0.1)
            }else if(textField == txtFund7){
                self.performSelector(#selector(HomeScreenViewController.setNextResponder(_:)), withObject: txtFund8, afterDelay: 0.1)
            }else if(textField == txtFund8){
                self.performSelector(#selector(HomeScreenViewController.setNextResponder(_:)), withObject: txtFund9, afterDelay: 0.1)
            }else if(textField == txtFund9){
                self.performSelector(#selector(HomeScreenViewController.setNextResponder(_:)), withObject: txtFund10, afterDelay: 0.1)
            }else if(textField == txtFund10){
                 self.performSelector(#selector(HomeScreenViewController.setNextResponder(_:)), withObject: txtMemb1, afterDelay: 0.1)//Last position of Fundraiser Number
             //  txtFund10.resignFirstResponder()
            }else if(textField == txtMemb1){
              self.performSelector(#selector(HomeScreenViewController.setNextResponder(_:)), withObject: txtMemb2, afterDelay: 0.1)
            }else if(textField == txtMemb2){
                self.performSelector(#selector(HomeScreenViewController.setNextResponder(_:)), withObject: txtMemb3, afterDelay: 0.1)
            }else if(textField == txtMemb3){
                txtMemb3.resignFirstResponder()  //Last position of member Number
            }
            
            if(textField == txtMemb1 || textField == txtMemb2 || textField == txtMemb3){
              //  memArray.append(textField.text!)
            }else{
              //  fidArray.append(textField.text!)
            }
            
        }
        
      //  print("*: \(fidArray)")
      //  print("mem*: \(memArray)")
        
        return false
        
        }
    
    func setNextResponder(nextResponder:UITextField){
        nextResponder.becomeFirstResponder()
    }

    
    
    
    
    
    
//TODO: - Button Action
    
    @IBAction func btnSubmitClick(sender: AnyObject) {
       print("FID cound: \(fidArray.count) \n mem cound: \(memArray.count)")
        
        //Clear array
        fidArray.removeAll(keepCapacity: false)
        memArray.removeAll(keepCapacity: false)
        
        if(txtFund1.text != "" && txtFund2.text != "" && txtFund3.text != "" && txtFund4.text != "" && txtFund5.text != "" && txtFund6.text != "" && txtFund7.text != "" && txtFund8.text != "" && txtFund9.text != "" && txtFund10.text != ""){
            if(txtFund1.text != ""){
                fidArray.insert(txtFund1.text!, atIndex: 0)
            }
            if(txtFund2.text != ""){
                fidArray.insert(txtFund2.text!, atIndex: 1)
            }
            if(txtFund3.text != ""){
                fidArray.insert(txtFund3.text!, atIndex: 2)
            }
            if(txtFund4.text != ""){
                fidArray.insert(txtFund4.text!, atIndex: 3)
            }
            if(txtFund5.text != ""){
                fidArray.insert(txtFund5.text!, atIndex: 4)
            }
            if(txtFund6.text != ""){
                fidArray.insert(txtFund6.text!, atIndex: 5)
            }
            if(txtFund7.text != ""){
                fidArray.insert(txtFund7.text!, atIndex: 6)
            }
            if(txtFund8.text != ""){
                fidArray.insert(txtFund8.text!, atIndex: 7)
            }
            if(txtFund9.text != ""){
                fidArray.insert(txtFund9.text!, atIndex: 8)
            }
            if(txtFund10.text != ""){
                fidArray.insert(txtFund10.text!, atIndex: 9)
            }
        }else{
             delObj.displayAlert("", msg: "Please enter valid Fundraiser ID")
        }
        
        
        if(txtMemb1.text != "" && txtMemb2.text != "" && txtMemb3.text != ""){
            if(txtMemb1.text != ""){
                memArray.insert(txtMemb1.text!, atIndex: 0)
            }
            if(txtMemb2.text != ""){
                memArray.insert(txtMemb2.text!, atIndex: 1)
            }
            if(txtMemb3.text != ""){
                memArray.insert(txtMemb3.text!, atIndex: 2)
            }
        }else{
           delObj.displayAlert("", msg: "Please enter valid Member No.")
        }
        
        print(fidArray)
        print(memArray)
        
        print(fidArray.count)
        print(memArray.count)
        

        if(fidArray.count < 10 ){
            
             delObj.displayAlert("", msg: "Please enter valid Fundraiser ID")
          
        }else if(memArray.count < 3){
            
            
            delObj.displayAlert("", msg: "Please enter valid Member No.")
        }else{
            
            
            
            defaults.setValue(fidArray, forKey: "fidArray")
            defaults.setValue(memArray, forKey: "memArray")
            defaults.synchronize()
            
            tempfid = ""
            for i in 0...self.fidArray.count-1{
                tempfid = tempfid +  self.fidArray[i]
            }
            tempmid =  ""
            for j in 0...self.memArray.count-1{
                tempmid = tempmid + self.memArray[j]
            }
            
            sendUserDetails(tempfid, mid: tempmid)
            
          
       }
    }
    
    

}
