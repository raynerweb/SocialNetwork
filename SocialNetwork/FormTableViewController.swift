//
//  FormViewController.swift
//  SocialNetwork
//
//  Created by rayner on 03/06/21.
//

import UIKit
import CoreData

class FormTableViewController: UITableViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwdTextField: UITextField!
    
    @IBOutlet weak var checkPasswdTextField: UITextField!
    
    // Todos os campos acima entao ligados à este array
    @IBOutlet var textFields: [UITextField]! {
        didSet {
            textFields.forEach{ textFields in
                textFields.delegate = self
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let context = AppDelegate.viewContext
        
    }
    
}


// Comportamento que pula o cursor de TextField em TextField.
// Quando nao 'retorno' for acionado. Entao fecha o teclado com resignFirstResponder() e nenum outro campo é o firstResponder
extension FormTableViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == nameTextField {
            emailTextField.becomeFirstResponder()
        }
        if textField == emailTextField {
            passwdTextField.becomeFirstResponder()
        }
        if textField == passwdTextField {
            checkPasswdTextField.becomeFirstResponder()
        }
        return true
    }
    
}
