//
//  RegisterViewController.swift
//  LocaisRioApp
//
//  Created by Ramon dos Santos on 14/05/17.
//  Copyright © 2017 Ebix American Latin. All rights reserved.
//


import UIKit




class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userEmailTextField.delegate = self
        self.userPasswordTextField.delegate = self
        self.repeatPasswordTextField.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //funcoes para keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userEmailTextField.resignFirstResponder()
        userPasswordTextField.resignFirstResponder()
        repeatPasswordTextField.resignFirstResponder()
        return (true)
    }
    
    @IBAction func backLoginButton(_ sender: UIButton) {
        performSegue(withIdentifier: "segue_to_login", sender: nil)
    }
    
    @IBAction func registerButtonTapped(_ sender: AnyObject) {
        
        let userEmail = userEmailTextField.text
        let userPassword = userPasswordTextField.text
        let userRepeatPassword = repeatPasswordTextField.text
        
        
        //armazena os dados de usuario e senha
        UserDefaults.standard.set(userEmail, forKey: "userEmail")
        UserDefaults.standard.set(userPassword, forKey: "userPassword")
        UserDefaults.standard.synchronize()
        
        //MARK: VALIDAÇÕES
        
        func displayMyAlertMessage(userMessage:String) {
            let myAlert = UIAlertController(title:"Alerta", message:userMessage, preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
            
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
        }
        
        if ((userEmail?.isEmpty)! || (userPassword?.isEmpty)! || (userRepeatPassword?.isEmpty)!) {
            displayMyAlertMessage(userMessage: "Preencha todos os campos")
            return
        }
        
        if (userPassword != userRepeatPassword) {
            displayMyAlertMessage(userMessage: "As senhas não coincidem")
            return
        }
        
        
        func isValidEmailAddress(emailAddressString: String) -> Bool {
            
            var returnValue = true
            let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
            
            do {
                let regex = try NSRegularExpression(pattern: emailRegEx)
                let nsString = emailAddressString as NSString
                let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
                
                if results.count == 0 {
                    returnValue = false
                }
                
            } catch let error as NSError {
                print("invalid regex: \(error.localizedDescription)")
                returnValue = false
            }
            return  returnValue
        }
        
        
        let isEmailAddressValid = isValidEmailAddress(emailAddressString: userEmail!)
        
        if isEmailAddressValid {
            
            let myAlert = UIAlertController(title:"Alerta",message:"Usuário registrado com sucesso !!!",preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) {
                action in
                self.dismiss(animated: true, completion:nil)
            }
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion:nil)
        }
        else {
            displayMyAlertMessage(userMessage: "E-mail inválido")
        }
        
    }
    
}

