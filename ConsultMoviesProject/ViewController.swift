//
//  ViewController.swift
//  ConsultMoviesProject
//
//  Created by Diego Castro on 13/08/22.
//

import UIKit

class ViewController: UIViewController {
    
    var mrRobotImageView: UIImageView!
    var dBImageView: UIImageView!
    var textField1: UITextField!
    var textField2: UITextField!
    var logInButton: UIButton!
    var wrongLogInLabel: UILabel!
    var userName = "C"
    var passWord = "1"
    
    override func loadView() {
        view = UIView()
        
      
        let mrRobotImage = "MrRobot"
        let image = UIImage(named: mrRobotImage)
        mrRobotImageView = UIImageView(image: image!)
        mrRobotImageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(mrRobotImageView)
        
        let dBmoviesLogo = "movieDBB"
        let dBimage = UIImage(named: dBmoviesLogo)
        dBImageView = UIImageView(image: dBimage!)
        dBImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dBImageView)
        
        textField1 =  UITextField()
        textField1.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0) //initial padding of the entered text
        textField1.layer.cornerRadius = 5
        textField1.translatesAutoresizingMaskIntoConstraints = false
        textField1.textAlignment = .left
        textField1.placeholder = "Username"
        textField1.backgroundColor = .white
        textField1.textColor = .systemGray
        textField1.minimumFontSize = 10
        view.addSubview(textField1)
        
        textField2 =  UITextField()
        textField2.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0) //initial padding of the entered text
        textField2.layer.cornerRadius = 5
        textField2.translatesAutoresizingMaskIntoConstraints = false
        textField2.textAlignment = .left
        textField2.placeholder = "Password"
        textField2.backgroundColor = .white
        textField2.textColor = .systemGray
        textField2.minimumFontSize = 10
        view.addSubview(textField2)
        
        logInButton = UIButton()
        logInButton.layer.cornerRadius = 5
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        logInButton.setTitle("Log In", for: .normal)
        logInButton.backgroundColor = .systemGray3
        logInButton.configuration = .bordered()
        logInButton.setTitleColor(.white, for: .normal)
        logInButton.setTitleColor(.white, for: .highlighted)
        logInButton.addTarget(self, action: #selector(logInButtonAction), for: .touchUpInside)
        view.addSubview(logInButton)
        
        wrongLogInLabel = UILabel()
        wrongLogInLabel.translatesAutoresizingMaskIntoConstraints = false
        wrongLogInLabel.textAlignment = .center
        wrongLogInLabel.backgroundColor = .black
        view.addSubview(wrongLogInLabel)
        
        
       NSLayoutConstraint.activate([mrRobotImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
        mrRobotImageView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: -90), mrRobotImageView.heightAnchor.constraint(equalToConstant: 250), mrRobotImageView.widthAnchor.constraint(equalToConstant: 250),
                                     
            dBImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor), dBImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -110), dBImageView.heightAnchor.constraint(equalToConstant: 100), dBImageView.widthAnchor.constraint(equalToConstant: 100),
                                     
            textField1.centerXAnchor.constraint(equalTo: view.centerXAnchor), textField1.centerYAnchor.constraint(equalTo: dBImageView.bottomAnchor, constant: 50),textField1.heightAnchor.constraint(equalToConstant: 50), textField1.widthAnchor.constraint(equalToConstant: 300),
                                     
            textField2.centerXAnchor.constraint(equalTo: view.centerXAnchor), textField2.centerYAnchor.constraint(equalTo: textField1.bottomAnchor, constant: 50),textField2.heightAnchor.constraint(equalToConstant: 50), textField2.widthAnchor.constraint(equalToConstant: 300),
                    
            logInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor), logInButton.centerYAnchor.constraint(equalTo: textField2.bottomAnchor, constant: 50),logInButton.heightAnchor.constraint(equalToConstant: 50), logInButton.widthAnchor.constraint(equalToConstant: 300),

//
                                    ])
        
        

    }

    
    
    @objc func logInButtonAction(sender: UIButton!) {
        
        let textField1 = textField1.text
        let textField2 = textField2.text
        
        NSLayoutConstraint.activate([  wrongLogInLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor), wrongLogInLabel.centerYAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 50),wrongLogInLabel.heightAnchor.constraint(equalToConstant: 50), wrongLogInLabel.widthAnchor.constraint(equalToConstant: 300)])
        
        if textField1 != ""{
            if textField2 != "" {
                
            if textField1 == userName && textField2 == passWord {
                wrongLogInLabel.text = ""
                
           let mvc = MoviesGridViewController()
//                mvc.view.backgroundColor = .red
                mvc.navigationItem.hidesBackButton = true
                mvc.navigationController?.setNavigationBarHidden(false, animated: true)
                navigationController?.pushViewController(mvc, animated: true)
               
                
            } else {
                wrongLogInLabel.text = " Wrong Username or password"
                wrongLogInLabel.textColor = .red
            }
        } else {  wrongLogInLabel.text = "Empty Password"
            wrongLogInLabel.textColor = .red
        }
        } else {  wrongLogInLabel.text = "Empty UserName"
            wrongLogInLabel.textColor = .red
        }
    }
    

}

