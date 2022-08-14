//
//  MoviesViewController.swift
//  ConsultMoviesProject
//
//  Created by Diego Castro on 13/08/22.
//

import UIKit

class MoviesGridViewController: UIViewController {
    
    var results = [PopularMoviesData]()
    var release_date: String = ""
    var backdrop_path: String = ""
    let scrollView = UIScrollView(frame: CGRect(x: 0, y: 50, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    var theImage: UIImage!

        
    
    override func loadView() {
        view = UIView()
        
        view.backgroundColor = .black
        title = "TV Shows"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        let imageUrlString = "https://image.tmdb.org/t/p/w500/vViRXFnSyGJ2fzMbcc5sqTKswcd.jpg"
        guard let imageUrl:URL = URL(string: imageUrlString) else {
            return
        }
        
        
        // so we can see the frames
        scrollView.backgroundColor = UIColor.black
        
        // create a vertical stack view to hold the rows of buttons
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // add Scrollview to view
        self.view.addSubview(scrollView)
        
        // add stack view to scrollView
        scrollView.addSubview(verticalStackView)

        // now let's create the buttons and add them
        var idx = 1
        
        for _ in 0...24 {
            // create a "row" stack view
            let rowStack = UIStackView()
            // add it to the vertical stack view
            verticalStackView.addArrangedSubview(rowStack)
            
            for _ in 0...1 {
                
                // Start background thread so that image loading does not make app unresponsive
                
                  DispatchQueue.global().async { [weak self] in
                    
                    guard let self = self else { return }
                    
                    guard let imageData = try? Data(contentsOf: imageUrl) else {
                        return
                    }

                    
                    // When from a background thread, UI needs to be updated on main_queue
                   DispatchQueue.main.async {
                       let imageView = UIImageView(frame: CGRect(x:0, y:0, width:20, height:20))
                       imageView.center = self.view.center
                        let image = UIImage(data: imageData)
                        imageView.image = image
                       self.theImage = imageView.image
                        imageView.contentMode = UIView.ContentMode.scaleAspectFit
//                       self.view.addSubview(imageView)
                       
                       let buttonImageView = UIImageView(frame: CGRect(x:0, y:0, width:100, height:100))
                       buttonImageView.backgroundColor = .gray
       //                button.setTitle("\(idx)", for: .normal)
                       buttonImageView.layer.cornerRadius = 8
                       buttonImageView.image = self.theImage
                       self.view.addSubview(buttonImageView)
       //                button.setImage(theImage, for: .normal)
       //                 button.setImage(UIImage(named: "movieDBB"), for: .normal)
       //                button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
                       
                       // add button to row stack view
                       rowStack.addArrangedSubview(buttonImageView)
                       
                       // buttons should be 50x50
                       let widthProportion: CGFloat = 2.7
                       NSLayoutConstraint.activate([
                           buttonImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/widthProportion),
                           buttonImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/widthProportion),
                       ])
                    }
                }
         
                self.view = view
                
                
                idx += 1
            }
        }
        
        // finally, let's set our constraints
                
                // respect safe-area
                let safeG = view.safeAreaLayoutGuide

                NSLayoutConstraint.activate([
                    
                    // constrain scrollView
                    //  50-pts from bottom of label
                    //  Leading and Trailing to safe-area with 8-pts "padding"
                    //  Bottom to safe-area with 8-pts "padding"
                    scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50.0),
                    scrollView.leadingAnchor.constraint(equalTo: safeG.leadingAnchor, constant: 0),
                    scrollView.trailingAnchor.constraint(equalTo: safeG.trailingAnchor, constant: 0),
                    scrollView.bottomAnchor.constraint(equalTo: safeG.bottomAnchor, constant: -8.0),
                    
                    // constrain vertical stack view to scrollView Content Layout Guide
                    //  8-pts all around (so we have a little "padding")
                    verticalStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 8.0),
                    verticalStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: (UIScreen.main.bounds.width-(UIScreen.main.bounds.width*2/3))/2),
                    verticalStackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -(UIScreen.main.bounds.width-(UIScreen.main.bounds.width*2/3))/2),
                    verticalStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -8.0),
                    
                ])

        verticalStackView.spacing = 8.0
        verticalStackView.arrangedSubviews.forEach { v in
            if let stack = v as? UIStackView {
                stack.spacing = 8.0
            }
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "list.dash"),
            style: .plain,
            target: self,
            action: #selector(promptForAnswer)
        )
        
        if let filePath = Bundle.main.path(forResource: "movie_ids_08_12_2022", ofType: "json") {
            let fileUrl = URL(fileURLWithPath: filePath)
            let data = try? Data(contentsOf: fileUrl)
            if let data = data {
           parse(json: data)
            }
        }
        
        

        
        let urlMovieDetails = "https://api.themoviedb.org/3/movie/343611?api_key=a542477d1e1e86b87f271f115770d255"
        
        DispatchQueue.global(qos: .userInitiated).async {
      
            if let url = URL(string: urlMovieDetails) {

                if let data = try? Data(contentsOf: url) //This fetches the data from the API
                {
                    self.parseDetails(json: data)
                }
            }
        }
        
        
            
    }
    
   @objc func promptForAnswer () {
        //More code to come regarding the action of the UIBarButton
    }
    
    @objc func buttonAction (sender: UIButton!) {
         //More code to come regarding the action of the UIBarButton
        title = sender.title(for: .normal)
     }
    
    
    func parse (json: Data) {
        let decoder = JSONDecoder()
        if let jsonMoviesList = try? decoder.decode(PopularMoviesList.self, from: json) {
            results = jsonMoviesList.results
        }
        
    }
    
    func parseDetails (json: Data) {
        let decoder = JSONDecoder()
        if let jsonMovieDetails = try? decoder.decode(MovieDetails.self, from: json) {
            release_date = jsonMovieDetails.release_date
            backdrop_path = jsonMovieDetails.backdrop_path
        }
        
    }

}
