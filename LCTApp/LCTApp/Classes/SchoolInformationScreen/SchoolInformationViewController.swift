//
//  SchoolInformationViewController.swift
//  LCTApp
//
//  Created by Suraj MAC2 on 4/23/16.
//  Copyright © 2016 supaint. All rights reserved.
//

import UIKit

class SchoolInformationViewController: UIViewController {

    
    //TODO: - General
    let delObj = UIApplication.sharedApplication().delegate as! AppDelegate
    let defaults = NSUserDefaults.standardUserDefaults()
    
    
    var chapterName : String = String()
    var fidNo : String = String()
    //TODO: - Controlls
    
    @IBOutlet weak var imgBottom: UIImageView!
    @IBOutlet weak var imgBG: UIImageView!
    //Label
    @IBOutlet weak var lblFID: UILabel!
   
   
    @IBOutlet weak var lblMemberTitle: UILabel!
    @IBOutlet weak var lblMemberName: UILabel!
   
    
    @IBOutlet weak var lblChapterValue: UILabel!
    @IBOutlet weak var lblNPOTitle: UILabel!
    //Button
    
    @IBOutlet weak var btnYesOutlet: UIButton!
    @IBOutlet weak var btnNoOutlet: UIButton!

    
    
    
    //TODO: - Let's Play
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
        
        //Display user information
        if(defaults.valueForKey("AppUserDetails") != nil){
            
            let AppUserDetails = defaults.valueForKey("AppUserDetails") as! NSDictionary
            chapterName = (AppUserDetails["chapter"] as? String)!
            fidNo = "FID # : " + (AppUserDetails["strfid"] as? String)!
            self.lblFID.text = fidNo
            self.lblMemberName.text = AppUserDetails["membername"] as? String
            self.lblChapterValue.text = chapterName            
            
        }
        
        //Appearence
        let dict1 = [NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue]
      
        //Sorority Attributed String here
        let sororityAttriString = NSMutableAttributedString(string: "N.P.O", attributes: dict1)
        lblNPOTitle.attributedText = sororityAttriString
        
        
        
        //Member Attributed String here
        let memberAttriString = NSMutableAttributedString(string: "MEMBER", attributes: dict1)
        lblMemberTitle.attributedText = memberAttriString
        
        //Button
        btnYesOutlet.layer.cornerRadius = delObj.roundedCorner
        btnNoOutlet.layer.cornerRadius = delObj.roundedCorner
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        
    }
    
    //TODO: - Button Action
    
    @IBAction func btnYesClick(sender: AnyObject) {
        SVProgressHUD.showWithStatus("Loading...")
        defaults.setValue(true, forKey: "is_autologin")
        defaults.synchronize()
        
        SVProgressHUD.dismiss()
        let confVC = self.storyboard?.instantiateViewControllerWithIdentifier("idSchoolConfirmationViewController") as! SchoolConfirmationViewController
        self.navigationController?.pushViewController(confVC, animated: true)
    }
    
    @IBAction func btnNoClick(sender: AnyObject) {
        //send back to
        self.navigationController?.popViewControllerAnimated(true)
    }

}
