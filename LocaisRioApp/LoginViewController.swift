//
//  LoginViewController.swift
//  LocaisRioApp
//
//  Created by Ramon dos Santos on 14/05/17.
//  Copyright © 2017 Ebix American Latin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    //E-MAIL E SENHA PARA LOGAR.
    // email: sergey@earthlandia.com
    // senha: 1234
    
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userEmailTextField.delegate = self
        self.userPasswordTextField.delegate = self
        
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
        return (true)
    }
    
    //método para logar
    @IBAction func loginButtonTapped(_ sender: AnyObject) {
        
        
        let userEmail : String = userEmailTextField.text!
        let userPassword : String = userPasswordTextField.text!
        
        if (userPassword.isEmpty || userEmail.isEmpty){
            displayMyAlertMessage(userMessage: "Preencha todos os campos")
            return}
        
        //enviando dados do usuario ao server
        let myURL = NSURL(string: "http://www.earthlandia.com/user-register/userLogin.php")
        let request = NSMutableURLRequest(url:myURL! as URL);
        request.httpMethod = "POST"
        let postString = "email=\(userEmail)&password=\(userPassword)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask (with: request as URLRequest, completionHandler: {
            (data, response, error) in
            
            
            if error != nil {
                print("error\(error)")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary

                if let parseJSON = json {
                    let resultValue = parseJSON["status"] as? String
                    print("result\(resultValue)")
                    
                    if(resultValue == "Success") {
                    
                        UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                        UserDefaults.standard.synchronize()
                    
                        self.dismiss(animated: true, completion:nil)
                        }
                    }
                }
            catch {
                print("Error")
            }
        })
        task.resume()
        
    }
    

    //mostrarAlerta
    func displayMyAlertMessage(userMessage:String) {
        let myAlert = UIAlertController(title:"Alerta", message:userMessage, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion: nil)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
