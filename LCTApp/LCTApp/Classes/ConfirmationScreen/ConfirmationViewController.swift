//
//  ConfirmationViewController.swift
//  LCTApp
//
//  Created by Suraj MAC2 on 3/21/16.
//  Copyright © 2016 supaint. All rights reserved.
//

import UIKit
import Alamofire


class ConfirmationViewController: UIViewController {

    
    
//TODO: - General
    let delObj = UIApplication.sharedApplication().delegate as! AppDelegate
    let defaults = NSUserDefaults.standardUserDefaults()
    var returnKeyHandler : IQKeyboardReturnKeyHandler = IQKeyboardReturnKeyHandler()
    
    
    var chapterName : String = String()
    var fidNo : String = String()
    var memno : String = String()
    
    var fidNoToPass : String = String()
    
    
//TODO: - Controlls
    
    @IBOutlet weak var imgBottom: UIImageView!
    @IBOutlet weak var imgBG: UIImageView!
    //Label
    
    @IBOutlet weak var lblCollege: UILabel!
    @IBOutlet weak var lblSorority: UILabel!
    @IBOutlet weak var lblMemberName: UILabel!
    @IBOutlet weak var lblSororityTitle: UILabel!
    @IBOutlet weak var lblChapterTitle: UILabel!
    @IBOutlet weak var lblMemberTitle: UILabel!
    
    //Button
    @IBOutlet weak var btnSubmitOutlet: UIButton!
    @IBOutlet weak var btnResetOutlet: UIButton!
    
    
    //TextField
    @IBOutlet weak var txtEmailID: UITextField!
    
//TODO: - Let's Play
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        //IQKeyboardReturnKeyHandler Method
        returnKeyHandler = IQKeyboardReturnKeyHandler(controller: self)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
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
        
        var labeltitle : String = String()
        if(defaults.valueForKey("AppUserDetails") != nil){
            
            let AppUserDetails = defaults.valueForKey("AppUserDetails") as! NSDictionary
            chapterName = (AppUserDetails["chapter"] as? String)!
            fidNoToPass = (AppUserDetails["strfid"] as? String)!
            
            fidNo = "FID # : " + (AppUserDetails["strfid"] as? String)!
            self.lblMemberName.text = AppUserDetails["membername"] as? String
            self.lblSorority.text = AppUserDetails["sorority"] as? String
            self.lblCollege.text = AppUserDetails["college"] as? String
            memno = (AppUserDetails["strmem"] as? String)!
            labeltitle = (AppUserDetails["labeltitle"] as? String)!
            print("1: \(memno)")
        }
        
       
        
        
        //Appearance
       
        let dict = [NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue]
        
          let dict2  = [NSFontAttributeName : UIFont(name: "Calibri-Bold", size:19.0)!]
        
        
        //Sorority Attributed String here
        let sororityAttriString = NSMutableAttributedString(string: labeltitle, attributes: dict)        
        lblSororityTitle.attributedText = sororityAttriString
        
        //chapter Attributed String here
        let chapterAttriString = NSMutableAttributedString(string: "CHAPTER", attributes: dict)
        let chapterValueString = NSMutableAttributedString(string: ": " + chapterName, attributes: dict2)
        chapterAttriString.appendAttributedString(chapterValueString)
        lblChapterTitle.attributedText = chapterAttriString
        
        //member Attributed String here
        let memberAttriString = NSMutableAttributedString(string: "MEMBER", attributes: dict)
        lblMemberTitle.attributedText = memberAttriString
        
        btnResetOutlet.layer.cornerRadius = delObj.roundedCorner
        btnSubmitOutlet.layer.cornerRadius = delObj.roundedCorner
        
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//TODO: - Function
    
    //Validate EmailID
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let range = testStr.rangeOfString(emailRegEx, options:.RegularExpressionSearch)
        let result = range != nil ? true : false
        return result
    }
    
//TODO: - Button Action
    
    @IBAction func btnSubmitClick(sender: AnyObject) {
        SVProgressHUD.showWithStatus("Loading...")
        if(isValidEmail(txtEmailID.text!)){
            
            delObj.udidString = delObj.udidString.stringByReplacingOccurrencesOfString("-", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            if(self.delObj.deviceTokenToSend == ""){
                self.delObj.deviceTokenToSend = "simulator"
            }
            var loginType : String = String()
            if(defaults.valueForKey("loginType") as! String == "greek"){
                loginType = "greek"
            }else{
                loginType = "school"
            }
             print(loginType)
            
            let parameters = ["FIDNO":fidNoToPass,"MEMNO":memno,"DeveiceToken":self.delObj.deviceTokenToSend,"DeviceID":delObj.udidString,"EmailID":self.txtEmailID.text!,"flag":"updatemember","loginType":loginType]
            
            Alamofire.Manager.sharedInstance.request(.POST, "http://life-changes-today.com/webservices/greek_iosresponce.php", parameters: parameters ).responseJSON{
                response in
                print(parameters)
                print(response.result.value)
                if(response.result.isSuccess){
                    SVProgressHUD.dismiss() 
                    let outJSON = JSON(response.result.value!)
                    
                    if(outJSON["msgflag"].stringValue == "Success"){
                        
                        SVProgressHUD.dismiss()
                        self.delObj.displayAlert("LCT App", msg:outJSON["errormsg"].stringValue )
                         self.txtEmailID.text = ""
                    }else{
                        SVProgressHUD.dismiss()
                        self.delObj.displayAlert("LCT App", msg:outJSON["errormsg"].stringValue )
                    }
                    
                    
                }else{
                    SVProgressHUD.dismiss()
                    self.delObj.displayAlert("LCT App", msg: "Please check internet connection")
                }
                
                
            }
            
            //delObj.displayAlert("LCT App", msg: "Email Successfully Sent")
           
        }else{
            
            SVProgressHUD.dismiss()
            delObj.displayAlert("LCT App", msg: "Please enter valid Email Address")
        }
    }
    
    
    @IBAction func btnResetClick(sender: AnyObject) {
        
        let resetAlert = UIAlertController(title: "", message: "Clicking on \"RESET\" will require you to enter another Fundraiser ID No. and Member No.", preferredStyle: UIAlertControllerStyle.Alert)
        
        resetAlert.addAction(UIAlertAction(title: "RESET", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
            self.defaults.setValue(nil, forKey: "fidArray")
            self.defaults.setValue(nil, forKey: "memArray")
            self.defaults.setValue(false, forKey: "is_autologin")
            self.defaults.synchronize()
            //go to home
            self.navigationController?.popToRootViewControllerAnimated(true)
        }))
        resetAlert.addAction(UIAlertAction(title: "CANCEL", style: UIAlertActionStyle.Cancel, handler: nil))
        
        presentViewController(resetAlert, animated: true, completion: nil)
        
    }
    

}
