//
//  EmailLoginVC.swift
//  HoursTracker
//
//  Created by H A M I . on 15/09/2026.
//

import UIKit

class EmailLoginVC: UIViewController {

    //MARK: - @IBAOutlets -
    
    //MARK:  Labels -
    
    @IBOutlet weak var welcomeToHoursTrackerLbl: UILabel!
    @IBOutlet weak var orLbl: UILabel!
    //MARK: TextFields -
    
    
    //MARK: Buttons -
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var signUpAsGuestBtn: UIButton!
    //MARK: - LifeCycles -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

//MARK: - @IBActions -
    
    @IBAction func onTapGetStartedBtn() {

//        guard let loginVC = R.storyboard.authSB.loginVC() else {return}
//        
//        self.navigationController?.pushViewController(loginVC, animated: true)
        
        
    }
}
