//
//  AthletVC.swift
//  DatabasePattern
//
//  Created by Daniel Siegel on 28.12.16.
//  Copyright © 2016 Daniel Siegel. All rights reserved.
//

import UIKit

class AthletVC: UIViewController, UITextFieldDelegate {

    
    var athlet: Athlet?
    let dataSource =  AthletsCoreDataDataSource() // AthletsRealmDataSource()
    
    @IBOutlet weak var athletNameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let athlet = athlet {
            athletNameTextField.text = athlet.name
        }
    }
    
    
    @IBAction func saveBtnTouched(_ sender: UIButton) {
        
        if let athlet = athlet {
            if let updatedName = athletNameTextField.text {
                athlet.name = updatedName
            }
            dataSource.update(item: athlet)
        }

       _ = navigationController?.popViewController(animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
}
