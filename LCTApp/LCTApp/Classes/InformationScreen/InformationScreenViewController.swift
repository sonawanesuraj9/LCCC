//
//  InformationScreenViewController.swift
//  LCTApp
//
//  Created by Suraj MAC2 on 3/21/16.
//  Copyright © 2016 supaint. All rights reserved.
//

import UIKit

class InformationScreenViewController: UIViewController {

    
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
    @IBOutlet weak var lblSororityTitle: UILabel!
    @IBOutlet weak var lblChapterTitle: UILabel!
    @IBOutlet weak var lblMemberTitle: UILabel!
    @IBOutlet weak var lblMemberName: UILabel!
    @IBOutlet weak var lblSorority: UILabel!
    @IBOutlet weak var lblCollege: UILabel!
    
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
        
        var labeltitle : String = String()
        //Display user information
        if(defaults.valueForKey("AppUserDetails") != nil){
            
            let AppUserDetails = defaults.valueForKey("AppUserDetails") as! NSDictionary
            chapterName = (AppUserDetails["chapter"] as? String)!
            fidNo = "FID # : " + (AppUserDetails["strfid"] as? String)!
            self.lblFID.text = fidNo
            self.lblMemberName.text = AppUserDetails["membername"] as? String
            self.lblSorority.text = AppUserDetails["sorority"] as? String
            self.lblCollege.text = AppUserDetails["college"] as? String
            labeltitle = (AppUserDetails["labeltitle"] as? String)!
            
        }
        
        //Appearence
        let dict1 = [NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue]
        let dict2 = [NSFontAttributeName: UIFont(name: "Calibri-Bold", size: 19)!]
        
        //Sorority Attributed String here
        let sororityAttriString = NSMutableAttributedString(string: labeltitle, attributes: dict1)
        lblSororityTitle.attributedText = sororityAttriString
        
        //Chapter Attributed String here
        let chapterAttriString = NSMutableAttributedString(string: "CHAPTER", attributes: dict1)
        let chapterValueString = NSMutableAttributedString(string: ": " + chapterName, attributes: dict2)
        chapterAttriString.appendAttributedString(chapterValueString)
        lblChapterTitle.attributedText = chapterAttriString
        
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
        let confVC = self.storyboard?.instantiateViewControllerWithIdentifier("idConfirmationViewController") as! ConfirmationViewController
        self.navigationController?.pushViewController(confVC, animated: true)
    }
    
    @IBAction func btnNoClick(sender: AnyObject) {
        //send back to 
        self.navigationController?.popViewControllerAnimated(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
