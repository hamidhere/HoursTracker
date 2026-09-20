//
//  PhoneNoVC.swift
//  HoursTracker
//
//  Created by H A M I . on 15/09/2026.
//

import UIKit
import RswiftResources

class LoginPhoneVC: UIViewController {

    //MARK: - @IBAOutlets -
    
    //MARK:  Labels -
    
    @IBOutlet weak var yourNumberLbl: UILabel!
    @IBOutlet weak var sixDigitCodeLbl: UILabel!
    
    //MARK: TextFields -
    @IBOutlet weak var countryCodeTxtField: UITextField!
    @IBOutlet weak var phoneNoTxtField: UITextField!
    
    
    //MARK: Buttons -
    
    @IBOutlet weak var sendOTPBtn: UIButton!

    //MARK: - LifeCycles -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

//MARK: - @IBActions -
    
    @IBAction func onTapSendBtn() {

        guard let loginVC = R.storyboard.authSB.loginVC() else {return}
        
        self.navigationController?.pushViewController(loginVC, animated: true)
        
        
    }

}
