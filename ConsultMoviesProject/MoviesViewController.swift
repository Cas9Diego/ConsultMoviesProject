//
//  MoviesViewController.swift
//  ConsultMoviesProject
//
//  Created by Diego Castro on 13/08/22.
//

import UIKit

class MoviesViewController: UIViewController {
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        title = "PlaceHolder"
    
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "list.dash"),
            style: .plain,
            target: self,
            action: #selector(promptForAnswer)
        )


        // Do any additional setup after loading the view.
    }
    
   @objc func promptForAnswer () {
        
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
