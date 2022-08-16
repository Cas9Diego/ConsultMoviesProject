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
    var overview: String = ""
    var poster_path: String = ""
    var original_title: String = ""
    var vote_average: Double = 0
    let scrollView = UIScrollView(frame: CGRect(x: 0, y: 50, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    var theImage: UIImage!
    var urlsList: [URL?] = []
    var popularButton: UIButton!
    var topRatedButton: UIButton!
    var onTvButton: UIButton!
    var airingTodayButton: UIButton!
    let buttonColor: UIColor = .systemGray
    let selectedButtonColor: UIColor = .systemGray3
    let topButtonsCornerRadius: CGFloat = 5
    let imageButtonsCornerRadius: CGFloat = 10
    let topButtonFontSize: CGFloat = 10
    var detailsList: [DetailsList] = []
    
    
    
    
    
    override func loadView() {
        view = UIView()
        
        view.backgroundColor = .black
        title = "TV Shows"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        if let filePath = Bundle.main.path(forResource: "movie_ids_08_12_2022", ofType: "json") {
            let fileUrl = URL(fileURLWithPath: filePath)
            let data = try? Data(contentsOf: fileUrl)
            if let data = data {
                parse(json: data)
            }
        }
        
        popularButton = UIButton()
        popularButton.layer.cornerRadius = topButtonsCornerRadius
        popularButton.translatesAutoresizingMaskIntoConstraints = false
        popularButton.setTitle("Popular", for: .normal)
        let popularButtonTitle = NSAttributedString(string: "Popular", attributes: [NSAttributedString.Key.font: UIFont(name: "Helvetica", size: topButtonFontSize) as Any, NSAttributedString.Key.foregroundColor: UIColor.white ])
        popularButton.setAttributedTitle(popularButtonTitle, for: UIControl.State.normal)
        popularButton.titleLabel?.adjustsFontSizeToFitWidth = false
        popularButton.backgroundColor = selectedButtonColor
        popularButton.setTitleColor(.white, for: .normal)
        popularButton.configuration = .bordered()
        popularButton.setTitleColor(.white, for: .normal)
        popularButton.setTitleColor(.white, for: .highlighted)
        popularButton.addTarget(self, action: #selector(popularButtonAction), for: .touchUpInside)
        view.addSubview(popularButton)
        
        topRatedButton = UIButton()
        topRatedButton.layer.cornerRadius = topButtonsCornerRadius
        topRatedButton.translatesAutoresizingMaskIntoConstraints = false
        let topRatedButtonTitle = NSAttributedString(string: "Top Rated", attributes: [NSAttributedString.Key.font: UIFont(name: "Helvetica", size: topButtonFontSize) as Any, NSAttributedString.Key.foregroundColor: UIColor.white ])
        topRatedButton.setAttributedTitle(topRatedButtonTitle, for: UIControl.State.normal)
        topRatedButton.titleLabel?.adjustsFontSizeToFitWidth = true
        topRatedButton.backgroundColor =  buttonColor
        topRatedButton.configuration = .bordered()
        topRatedButton.setTitleColor(.white, for: .normal)
        topRatedButton.setTitleColor(.white, for: .highlighted)
        topRatedButton.addTarget(self, action: #selector(topRatedButtonAction), for: .touchUpInside)
        view.addSubview(topRatedButton)
        
        onTvButton = UIButton()
        onTvButton.layer.cornerRadius = topButtonsCornerRadius
        onTvButton.translatesAutoresizingMaskIntoConstraints = false
        let onTvButtonTitle = NSAttributedString(string: "On Tv", attributes: [NSAttributedString.Key.font: UIFont(name: "Helvetica", size: topButtonFontSize) as Any, NSAttributedString.Key.foregroundColor: UIColor.white ])
        onTvButton.setAttributedTitle(onTvButtonTitle, for: UIControl.State.normal)
        topRatedButton.titleLabel?.adjustsFontSizeToFitWidth = true
        onTvButton.backgroundColor =  buttonColor
        onTvButton.configuration = .bordered()
        onTvButton.setTitleColor(.white, for: .normal)
        onTvButton.setTitleColor(.white, for: .highlighted)
        onTvButton.addTarget(self, action: #selector(onTvButtonAction), for: .touchUpInside)
        view.addSubview(onTvButton)
        
        airingTodayButton = UIButton()
        airingTodayButton.layer.cornerRadius = topButtonsCornerRadius
        airingTodayButton.translatesAutoresizingMaskIntoConstraints = false
        let AiringTodayButtonTitle = NSAttributedString(string: "Airing Today", attributes: [NSAttributedString.Key.font: UIFont(name: "Helvetica", size: topButtonFontSize) as Any, NSAttributedString.Key.foregroundColor: UIColor.white ])
        airingTodayButton.setAttributedTitle(AiringTodayButtonTitle, for: UIControl.State.normal)
        topRatedButton.titleLabel?.adjustsFontSizeToFitWidth = true
        airingTodayButton.backgroundColor =  buttonColor
        airingTodayButton.configuration = .bordered()
        airingTodayButton.setTitleColor(.white, for: .normal)
        airingTodayButton.setTitleColor(.white, for: .highlighted)
        airingTodayButton.addTarget(self, action: #selector(airingTodayButtonAction), for: .touchUpInside)
        view.addSubview(airingTodayButton)
        
        //        --------------------------------------------------------------------
        
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
        var movieURLSelector = 0
        var idx = 0
        
        for _ in 0..<results.count/2 {
            
            
            // create a "row" stack view
            let rowStack = UIStackView()
            // add it to the vertical stack view
            verticalStackView.addArrangedSubview(rowStack)
            
            for _ in 0...1 {
                
                let urlMovieDetails = "https://api.themoviedb.org/3/movie/"+"\(results[movieURLSelector ].id)"+"?api_key=a542477d1e1e86b87f271f115770d255"
                
                print("About to save list elements")
                
                DispatchQueue.main.async {
                    
                    if let url = URL(string: urlMovieDetails) {
                        
                        if let data = try? Data(contentsOf: url) //This fetches the data from the API
                        {
                            self.parseDetails(json: data)
                            let imageUrlString = URL(string: "https://image.tmdb.org/t/p/w500/"+self.backdrop_path)
                            //                        print(imageUrlString, "TheURL")
                            self.urlsList.append(imageUrlString)
                            
                            var detailsStruct = DetailsList()
                            detailsStruct.backdrop_path = self.backdrop_path
                            detailsStruct.overview = self.overview
                            detailsStruct.release_date = self.release_date
                            detailsStruct.poster_path = "https://image.tmdb.org/t/p/w500"+"\(self.poster_path)"
                            detailsStruct.original_title = self.original_title
                            detailsStruct.vote_average = self.vote_average
                            
                            self.detailsList.append(detailsStruct)
                            
                            
                            // Start background thread so that image loading does not make app unresponsive
                            
                            DispatchQueue.global().async { [weak self] in
                                
                                guard let self = self else { return }
                                
                                guard let imageData = try? Data(contentsOf: imageUrlString!) else {
                                    return
                                }
                                // When from a background thread, UI needs to be updated on main_queue
                                DispatchQueue.main.async {
                                    let imageView = UIImageView()
                                    imageView.center = self.view.center
                                    let image = UIImage(data: imageData)
                                    imageView.image = image
                                    imageView.layer.cornerRadius = 10
                                    imageView.clipsToBounds = true
                                    self.theImage = imageView.image
                                    
                                    
                                    let movieInfo = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width*1/3, height: UIScreen.main.bounds.width*2/3))
                                    movieInfo.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.1)
                                    let tapMovieButton = UIButton()
                                    tapMovieButton.backgroundColor = .gray
                                    tapMovieButton.setImage(self.theImage, for: .normal)
                                    tapMovieButton.layer.cornerRadius = self.imageButtonsCornerRadius
                                    tapMovieButton.clipsToBounds = true
                                    tapMovieButton.setTitle("\(idx)", for: .normal)
                                    //                                    movieInfo.mask = tapMovieButton
                                    
                                    tapMovieButton.addTarget(self, action: #selector(self.movieButtonAction), for: .touchUpInside)
                                    
                                    // add button to row stack view
                                    //                                    tapMovieButton.addSubview(movieInfo)
                                    tapMovieButton.addSubview(movieInfo)
                                    rowStack.addArrangedSubview(tapMovieButton)
                                    idx += 1
                                    // buttons size
                                    let widthProportion: CGFloat = 2/6
                                    NSLayoutConstraint.activate([
                                        tapMovieButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width*widthProportion),
                                        tapMovieButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width*widthProportion)
                                   
                                    ])
                                }
                            }
                        }
                    }
                }
                movieURLSelector+=1
            }
        }
        
        // finally, let's set our constraints
        
        // respect safe-area
        let safeG = view.safeAreaLayoutGuide
        let buttonWidthAnchor: CGFloat = UIScreen.main.bounds.width*3/16
        let buttonLeadingAnchor: CGFloat = (UIScreen.main.bounds.width/8)
        
        
        NSLayoutConstraint.activate([
            popularButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: buttonLeadingAnchor), popularButton.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 50),popularButton.heightAnchor.constraint(equalToConstant: 25), popularButton.widthAnchor.constraint(equalToConstant: buttonWidthAnchor),
            
            topRatedButton.centerXAnchor.constraint(equalTo: popularButton.layoutMarginsGuide.trailingAnchor, constant: 50),  topRatedButton.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 50), topRatedButton.heightAnchor.constraint(equalToConstant: 25),  topRatedButton.widthAnchor.constraint(equalToConstant: buttonWidthAnchor),
            
            onTvButton.centerXAnchor.constraint(equalTo: topRatedButton.layoutMarginsGuide.trailingAnchor, constant: 50), onTvButton.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 50),onTvButton.heightAnchor.constraint(equalToConstant: 25), onTvButton.widthAnchor.constraint(equalToConstant: buttonWidthAnchor),
            
            airingTodayButton.centerXAnchor.constraint(equalTo: onTvButton.layoutMarginsGuide.trailingAnchor, constant: 50), airingTodayButton.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 50),airingTodayButton.heightAnchor.constraint(equalToConstant: 25), airingTodayButton.widthAnchor.constraint(equalToConstant: buttonWidthAnchor),
            
            // constrain scrollView
            //  50-pts from bottom of label
            //  Leading and Trailing to safe-area with 8-pts "padding"
            //  Bottom to safe-area with 8-pts "padding"
            scrollView.topAnchor.constraint(equalTo: popularButton.bottomAnchor, constant: 10),
            scrollView.leadingAnchor.constraint(equalTo: safeG.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: safeG.trailingAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: safeG.bottomAnchor, constant: -8.0),
            
            // constrain vertical stack view to scrollView Content Layout Guide
            //  8-pts all around (so we have a little "padding")
            verticalStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 8.0),
            verticalStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: (UIScreen.main.bounds.width/6)),
            verticalStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -8.0),  verticalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
            
            
            
            //
            
            
        ])
        
        verticalStackView.spacing = 8.0
        verticalStackView.arrangedSubviews.forEach { v in
            if let stack = v as? UIStackView {
                stack.spacing = 8.0
            }
        }
        
        //        --------------------------------------------------------------------
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "list.dash"),
            style: .plain,
            target: self,
            action: #selector(promptForAnswer)
        )
        
        
        
    }
    
    @objc func promptForAnswer () {
        let ac = UIAlertController(title: "What do you want to do?", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "View Profile", style: .default, handler: viewProfile))
        ac.addAction(UIAlertAction(title: "Log out", style: .destructive, handler: logOut))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present (ac, animated: true)
    }
    
     func viewProfile (action: UIAlertAction) {
         let mvc = ProfileViewController()
         mvc.navigationController?.setNavigationBarHidden(false, animated: true)
         navigationController?.pushViewController(mvc, animated: true)
    }
    
     func logOut (action: UIAlertAction) {
         let mvc = ViewController()
         mvc.navigationItem.hidesBackButton = true
         mvc.navigationController?.setNavigationBarHidden(false, animated: true)
         navigationController?.pushViewController(mvc, animated: true)
    }
    
    @objc func movieButtonAction (sender: UIButton!) {
        //More code to come regarding the action of the UIBarButton
        //        title = sender.title(for: .normal)
        if let movieID: String = sender.title(for: .normal) {
            let mvc = MovieInfoViewController()
            mvc.release_date = detailsList[Int(movieID)!].release_date
            mvc.overview = detailsList[Int(movieID)!].overview
            mvc.backdrop_path = detailsList[Int(movieID)!].backdrop_path
            mvc.vote_average = detailsList[Int(movieID)!].vote_average
            mvc.poster_path = detailsList[Int(movieID)!].poster_path
            mvc.original_title = detailsList[Int(movieID)!].original_title
   
        mvc.navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.pushViewController(mvc, animated: true)
        }
        
    }
    
    @objc func popularButtonAction (sender: UIButton!) {
        
        popularButton.backgroundColor = selectedButtonColor
        topRatedButton.backgroundColor = buttonColor
        onTvButton.backgroundColor = buttonColor
        airingTodayButton.backgroundColor = buttonColor
        title = "Popular"
        
        
        
    }
    
    @objc func topRatedButtonAction (sender: UIButton!) {
        
        popularButton.backgroundColor = buttonColor
        topRatedButton.backgroundColor = selectedButtonColor
        onTvButton.backgroundColor = buttonColor
        airingTodayButton.backgroundColor = buttonColor
        title = "Top Rated"
        
    }
    
    @objc func onTvButtonAction (sender: UIButton!) {
        
        popularButton.backgroundColor = buttonColor
        topRatedButton.backgroundColor = buttonColor
        onTvButton.backgroundColor = selectedButtonColor
        airingTodayButton.backgroundColor = buttonColor
        title = "On Tv"
        
    }
    
    @objc func airingTodayButtonAction (sender: UIButton!) {
        
        popularButton.backgroundColor = buttonColor
        topRatedButton.backgroundColor = buttonColor
        onTvButton.backgroundColor = buttonColor
        airingTodayButton.backgroundColor = selectedButtonColor
        
        title = "Airing Today"
        
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
            overview = jsonMovieDetails.overview
            poster_path = jsonMovieDetails.poster_path
            original_title = jsonMovieDetails.original_title
            vote_average = jsonMovieDetails.vote_average
            
        }
        
    }
    
}
