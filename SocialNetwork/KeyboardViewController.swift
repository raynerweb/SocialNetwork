//
//  KeyboardViewController.swift
//  SocialNetwork
//
//  Created by rayner on 03/06/21.
//

import UIKit

class KeyboardViewController: UIViewController {

    private var initialValue: CGFloat = 0
    
    @IBOutlet weak var textField: UITextField! {
        didSet {
            // Registra o evendo de esconder o teclado
            // quando o botao de 'retorno' for clicado
            textField.delegate = self
        }
    }
    
    @IBOutlet weak var TextFieldBottomConstraint: NSLayoutConstraint! {
        didSet {
            // pega o valor inicial da constraint bottom
            initialValue = TextFieldBottomConstraint.constant
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Registra evento que aumenta o tamanho da constraintBottom da TextView
        // de acordo com o top do teclado que aparecer na tela
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardDidAppear(_:)),
            name: UIResponder.keyboardDidShowNotification,
            object: view.window)
        
        
        //Registra evento que diminui o tamanho da constraintBottom da TextView
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardDidDisapper(_:)),
            name: UIResponder.keyboardDidHideNotification,
            object: view.window)
        
        
        // Cria evento que esconde o teclado quando o textField perde o foco
        let tapGesture = UITapGestureRecognizer(target: textField, action: #selector(textField.resignFirstResponder))
        
        // Registra evento na viewController para quando o textField perder o foco
        // acionar o textField.resignFirstResponder()
        self.view.addGestureRecognizer(tapGesture)
    }
    
    // Metodo que aumenta o tamanho da constraint
    @objc private func keyboardDidAppear(_ sender: Notification) {
        if let frame = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            TextFieldBottomConstraint.constant = initialValue + frame.size.height
        }
    }
    
    
    //Metodo que diminui o tamanho da constraint
    @objc private func keyboardDidDisapper(_ sender: Notification) {
            TextFieldBottomConstraint.constant = initialValue
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // Remove os eventos registrados
        NotificationCenter.default.removeObserver(self)
    }

}


extension KeyboardViewController: UITextFieldDelegate {
    
    // Metodo que registra o evento que deve esconder o teclado quando o
    // botao de 'retorno' for clicado
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
