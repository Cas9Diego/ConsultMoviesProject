//
//  ProfileViewController.swift
//  ConsultMoviesProject
//
//  Created by Diego Castro on 16/08/22.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var profileTextLabel: UILabel!
    var profileImageView: UIImageView!
    var profileNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = UIView()
        
        profileTextLabel = UILabel()
        profileTextLabel.translatesAutoresizingMaskIntoConstraints = false
        profileTextLabel.textAlignment = .center
        profileTextLabel.backgroundColor = .black
        profileTextLabel.text = "Profile"
        profileTextLabel.font = profileTextLabel.font.withSize(30)
        profileTextLabel.textColor = .green
        profileTextLabel.layer.borderWidth = 0.3
        //        profileTextLabel.layer.borderColor = UIColor.white.cgColor
        profileTextLabel.numberOfLines = .min
        profileTextLabel.layer.cornerRadius = 10
        profileTextLabel.clipsToBounds = true
        view.addSubview(profileTextLabel)
        
        let profilePlaceHolder = "profilePlaceholder"
        let image = UIImage(named: profilePlaceHolder)
        profileImageView = UIImageView(image: image!)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileImageView)
        
        profileNameLabel = UILabel()
        profileNameLabel.translatesAutoresizingMaskIntoConstraints = false
        profileNameLabel.textAlignment = .center
        profileNameLabel.backgroundColor = .black
        profileNameLabel.text = "@CoppelTester"
        profileNameLabel.font = profileTextLabel.font.withSize(15)
        profileNameLabel.textColor = .green
        profileNameLabel.layer.borderWidth = 0.3
        //        profileTextLabel.layer.borderColor = UIColor.white.cgColor
        profileNameLabel.numberOfLines = .min
        profileNameLabel.layer.cornerRadius = 10
        profileNameLabel.clipsToBounds = true
        view.addSubview(profileNameLabel)
        
        
        NSLayoutConstraint.activate([profileTextLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: UIScreen.main.bounds.height/10),
                                      profileTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIScreen.main.bounds.width/8),  profileTextLabel.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/13), profileTextLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/3),
                                     
                                     profileImageView.topAnchor.constraint(equalTo: profileTextLabel.bottomAnchor, constant: 10),
                                     profileImageView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: UIScreen.main.bounds.width/8), profileImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/7), profileImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/7),
                                     
                                     profileNameLabel.topAnchor.constraint(equalTo: profileTextLabel.bottomAnchor, constant: 10),
                                     profileNameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: UIScreen.main.bounds.width/20), profileNameLabel.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/7), profileNameLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/7)
                                      
                                      
                                    ])
        
        
        // Do any additional setup after loading the view.
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
