//
//  SignInVC.swift
//  Edvora_Swift
//
//  Created by Nirzar Gandhi on 17/11/21.
//

class SignInVC: UIViewController {
    
    //MARK: - UIView Outlets
    @IBOutlet weak var vUsername: UIView!
    @IBOutlet weak var vPassword: UIView!
    
    //MARK: - UITextField Outlets
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    //MARK: - UIButton Outlet
    @IBOutlet weak var btnShowHidePassword: UIButton!
    
    //MARK: - ViewController Method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialization()
    }
    
    //MARK: - Initialization Method
    func initialization() {
        hideNavigationBar()
    }
    
    //MARK: - Set Default TextField Boder Method
    func setDefaultTextFieldBorder() {
        vUsername.borderColor = .appBorder()
        vPassword.borderColor = .appBorder()
    }
    
    //MARK: - UIButton Action Methods
    @IBAction func btnShowHidePasswordAction(_ sender: Any) {
        
        hideIQKeyboard()
        
        setDefaultTextFieldBorder()
        
        btnShowHidePassword.isSelected = !btnShowHidePassword.isSelected
        txtPassword.isSecureTextEntry = !txtPassword.isSecureTextEntry
    }
    
    @IBAction func btnForgotPasswordAction(_ sender: Any) {
        
        hideIQKeyboard()
        
        setDefaultTextFieldBorder()
        
        self.view.makeToast(AlertMessage.msgInProgress)
    }
    
    @IBAction func btnLoginAction(_ sender: Any) {
        
        hideIQKeyboard()
        
        setDefaultTextFieldBorder()
        
        if txtUsername.isEmpty {
            self.view.makeToast(AlertMessage.msgUsername)
        } else if !txtUsername.checkLength(withMinLimit: 2) {
            self.view.makeToast(AlertMessage.msgUsernameCharacter)
        } else if !txtUsername.validateUsername() {
            self.view.makeToast(AlertMessage.msgValidUsername)
        } else if txtPassword.isEmpty {
            self.view.makeToast(AlertMessage.msgPassword)
        } else if !txtPassword.checkLength(withMaxLimit: 8) {
            self.view.makeToast(AlertMessage.msgPasswordCharacter)
        } else if !txtPassword.validatePassword() {
            self.view.makeToast(AlertMessage.msgValidPassword)
        } else {
            self.view.makeToast(AlertMessage.msgInProgress)
        }
    }
    
    @IBAction func btnSignUpAction(_ sender: Any) {
        
        hideIQKeyboard()
        
        setDefaultTextFieldBorder()
        
        self.view.makeToast(AlertMessage.msgInProgress)
    }
}

//MARK: - UITextField Delegate Extension
extension SignInVC : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        setDefaultTextFieldBorder()
        
        if textField == txtUsername {
            vUsername.borderColor = .appBF9B9B()
        } else {
            vPassword.borderColor = .appBF9B9B()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.returnKeyType == UIReturnKeyType.next {
            textField.superview?.superview?.superview?.viewWithTag(textField.tag + 1)?.becomeFirstResponder()
        } else if textField.returnKeyType == UIReturnKeyType.done {
            textField.resignFirstResponder()
            
            setDefaultTextFieldBorder()
        }
        
        return true
    }
}
