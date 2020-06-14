//
//  AboutApp.swift
//  Repositories
//
//  Created by Elizeus on 14/06/2020.
//  Copyright © 2020 Elizeus. All rights reserved.
//

import UIKit

class AboutApp: UIViewController {
    
    @IBOutlet var aboutLabel: UILabel!
    @IBOutlet var firstNameLabel: UILabel!
    @IBOutlet var lastNameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameLabel.text = "Elizej"
        lastNameLabel.text = "Chrabrov"
        emailLabel.text = "elizeus.chrabrov@gmail.com"
        aboutLabel.text = "This is a test iOS application that displays GitHub user repositories, branches and commits."
    }
}
