//
//  LoginVC.swift
//  StarWarsAPITest
//
//  Created by Kent Franks on 2/19/19.
//  Copyright © 2019 Kent Franks. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var discoModeLabel: UILabel!
    @IBOutlet weak var discoModeSwitch: UISwitch!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - Properties
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if Session.environment == .dev {
//            discoModeSwitch.isHidden = false
//            discoModeLabel.isHidden = false
//        } else {
//            discoModeSwitch.isHidden = true
//            discoModeLabel.isHidden = true
//        }
    }
    
    // MARK: - Actions
    @IBAction func loginAction(_ sender: Any) {
//        Session.discoMode = discoModeSwitch.isOn
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
