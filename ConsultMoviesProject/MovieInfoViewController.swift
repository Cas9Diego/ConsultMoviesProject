//
//  MovieInfoViewController.swift
//  ConsultMoviesProject
//
//  Created by Diego Castro on 16/08/22.
//

import UIKit

class MovieInfoViewController: UIViewController, ObservableObject {
    
    var release_date: String = ""
    var vote_average: Double = 0
    var backdrop_path: String = ""
    var overview: String = ""
    var poster_path: String = ""
    var original_title: String = ""
    var movieDescriptionLabel: UILabel!
    var releaseDateLabel: UILabel!
    var averageVotesLabel: UILabel!
    var posterImage: UIImage!
    var theimageView: UIImageView!
    
    
    override func loadView() {
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = UIView()
        
        title = original_title
        
        self.theimageView = UIImageView()
        self.theimageView.translatesAutoresizingMaskIntoConstraints = false
        self.theimageView.center = self.view.center
        
        movieDescriptionLabel = UILabel()
        movieDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        movieDescriptionLabel.textAlignment = .center
        movieDescriptionLabel.backgroundColor = .black
        movieDescriptionLabel.text = overview
        movieDescriptionLabel.adjustsFontSizeToFitWidth = true
        movieDescriptionLabel.textColor = .white
        movieDescriptionLabel.layer.borderWidth = 0.3
        movieDescriptionLabel.layer.borderColor = UIColor.white.cgColor
        movieDescriptionLabel.numberOfLines = .min
        movieDescriptionLabel.layer.cornerRadius = 10
        movieDescriptionLabel.clipsToBounds = true
        view.addSubview(movieDescriptionLabel)
        
        releaseDateLabel = UILabel()
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseDateLabel.textAlignment = .center
        releaseDateLabel.backgroundColor = .black
        releaseDateLabel.text = "Release date: "+release_date
        releaseDateLabel.adjustsFontSizeToFitWidth = true
        releaseDateLabel.textColor = .white
        releaseDateLabel.layer.borderWidth = 0.3
        releaseDateLabel.layer.borderColor = UIColor.white.cgColor
        releaseDateLabel.numberOfLines = .min
        releaseDateLabel.layer.cornerRadius = 10
        releaseDateLabel.clipsToBounds = true
        view.addSubview(releaseDateLabel)
        
        averageVotesLabel = UILabel()
        averageVotesLabel.translatesAutoresizingMaskIntoConstraints = false
        averageVotesLabel.textAlignment = .center
        averageVotesLabel.backgroundColor = .black
        averageVotesLabel.text = "Average votes: "+"\(vote_average)"
        averageVotesLabel.adjustsFontSizeToFitWidth = true
        averageVotesLabel.textColor = .white
        averageVotesLabel.layer.borderWidth = 0.3
        averageVotesLabel.layer.borderColor = UIColor.white.cgColor
        averageVotesLabel.numberOfLines = .min
        averageVotesLabel.layer.cornerRadius = 10
        averageVotesLabel.clipsToBounds = true
        view.addSubview(averageVotesLabel)
        
        DispatchQueue.global().async { [weak self] in
            
            guard let self = self else { return }
            
            guard let imageData = try? Data(contentsOf: URL(string: self.poster_path)!) else {
                return
            }
            DispatchQueue.main.async {
                let image = UIImage(data: imageData)
                self.theimageView.image = image
                self.theimageView.layer.cornerRadius = 10
                self.theimageView.clipsToBounds = true
                self.posterImage = self.theimageView.image
                self.view.addSubview(self.theimageView)
                
                NSLayoutConstraint.activate([self.theimageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: UIScreen.main.bounds.height/7),
                                             self.theimageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: UIScreen.main.bounds.width/3), self.theimageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/3), self.theimageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/3),
                                             
                                             
                                             self.movieDescriptionLabel.topAnchor.constraint(equalTo: self.theimageView.bottomAnchor, constant: 20),
                                             self.movieDescriptionLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: UIScreen.main.bounds.width/6), self.movieDescriptionLabel.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/5), self.movieDescriptionLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width*2/3),
                                             
                                             self.releaseDateLabel.topAnchor.constraint(equalTo: self.movieDescriptionLabel.bottomAnchor, constant: 20),
                                             self.releaseDateLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: UIScreen.main.bounds.width/6), self.releaseDateLabel.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/20), self.releaseDateLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width*1/5),
                                             
                                             self.averageVotesLabel.topAnchor.constraint(equalTo: self.movieDescriptionLabel.bottomAnchor, constant: 20),
                                             self.averageVotesLabel.trailingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: UIScreen.main.bounds.width*5/6), self.averageVotesLabel.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/20), self.averageVotesLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width*1/5)
                                             
                                            ])
            }
            
        }
        
        
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
