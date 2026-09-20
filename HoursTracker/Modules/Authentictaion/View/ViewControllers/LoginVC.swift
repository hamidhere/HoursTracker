//
//  LoginVCViewController.swift
//  HoursTracker
//
//  Created by H A M I . on 11/09/2026.
//

import UIKit
import RswiftResources

class LoginVC: UIViewController {
    
    //MARK: - @IBOutlets -
    
    //MARK:  Labels -
    @IBOutlet weak var GuestHoursLbl: UILabel!
    
    //MARK:  Labels -
    @IBOutlet weak var loginGoogleBtn: UIButton!
    @IBOutlet weak var loginEmailBtn: UIButton!
    @IBOutlet weak var phoneNumBtn: UIButton!
    @IBOutlet weak var continueGuestBtn: UIButton!
    
    
    //MARK: - LifeCycles -
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - @IBActions -
    
    @IBAction func onTapLoginGoogle() {
        
        guard let google = R.storyboard.authSB.loginGoogleVC() else {return}
        self.navigationController?.pushViewController(google, animated: true)
        
        
    }
    @IBAction func onTaploginEmail() {
        
        guard let email = R.storyboard.authSB.emailLoginVC() else {return}
        
        
        self.navigationController?.pushViewController(email, animated: true)
        
        
    }
    
    @IBAction func onTapPhoneNum() {
     
        guard let phone = R.storyboard.authSB.loginPhoneVC() else {return}
        
        self.navigationController?.pushViewController(phone, animated: true)
        
    }
    
    @IBAction func onTapGuest() {
        
        guard let sb = R.storyboard.mainTabBarSB.mainTabBarVC() else {return}
        print("PAssed")
        sb.modalPresentationStyle = .fullScreen
        self.present(sb, animated: true)
        
    }
    
}
