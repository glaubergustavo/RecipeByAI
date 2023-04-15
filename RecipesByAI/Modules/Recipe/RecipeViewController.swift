//
//  RecipeViewController.swift
//  Victory Health
//
//  Created by Glauber Gustavo on 24/02/23.
//  Copyright © 2023 MadeinWeb. All rights reserved.
//

import UIKit

@objc class RecipeViewController: UIViewController,
                                  UITextViewDelegate,
                                  RecipePresenterDelegate {
    
    // MARK: -@IBOutlet View Thanks
    @IBOutlet weak var lblThanks: UILabel!
    @IBOutlet weak var vwBackground: UIView!
    @IBOutlet weak var vwPopupThanks: UIView!
    @IBOutlet weak var btnExit: UIButton!
    @IBOutlet weak var btnSeeMoodData: UIButton!
    @IBOutlet weak var centerConstraint: NSLayoutConstraint!
    var centerYConstraint: NSLayoutConstraint?
    
    // MARK: -@IBOutlet ScrollView
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var actLoading: UIActivityIndicatorView!
    
    // MARK: -@IBOutlet Mood status Views
    @IBOutlet weak var vwRecipeImage: UIView!
    @IBOutlet weak var imgRecipe: UIImageView!
    @IBOutlet weak var lblRecipeTitle: UILabel!
    @IBOutlet weak var textViewRecipe: UITextView!
    
    // MARK: Variables
    var presenter: RecipePresenter!
    
    //-----------------------------------------------------------------------
    //  MARK: - Life Cycle
    //-----------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadUI()
    }
    
    //-----------------------------------------------------------------------
    //  MARK: - Custom Methods
    //-----------------------------------------------------------------------
    
    private func loadUI() {
        lblRecipeTitle.text = presenter.recipeTitle
    }
    
    private func configUI() {
        
        configRecipeTitle()
        hideAnimationVwThanks()
        configNavBar()
        configLabels()
        configTextView()
    }
    
    private func configRecipeTitle() {
        presenter.configRecipeTitle()
    }
    
    private func hideAnimationVwThanks() {
        if self.centerYConstraint != nil {
            view.removeConstraint(self.centerYConstraint!)
        }

        self.centerYConstraint = NSLayoutConstraint(item: self.vwPopupThanks as Any,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: view,
                                               attribute: .bottom,
                                               multiplier: 1,
                                               constant: 0)
        
        view.addConstraint(self.centerYConstraint!)

        self.vwBackground.alpha = 0
        self.vwPopupThanks.alpha = 0

        view.layoutIfNeeded()
    }
    
    private func showAnimationVwThanks() {
        
//        configAnimationPopupThanks()
        
        if self.centerYConstraint != nil {
            self.view.removeConstraint(self.centerYConstraint!)
        }
        
        UIView.animate(withDuration: 0.5) {

            self.centerYConstraint = NSLayoutConstraint(item: self.vwPopupThanks as Any,
                                                        attribute: .centerY,
                                                        relatedBy: .equal,
                                                        toItem: self.view,
                                                        attribute: .centerY,
                                                        multiplier: 1,
                                                        constant: -100)

            self.view.addConstraint(self.centerYConstraint!)
            
            self.navigationController?.navigationBar.alpha = 0
            self.vwPopupThanks.alpha = 1
            self.vwBackground.alpha = 0.7
            
            self.view.layoutIfNeeded()
            self.view.layoutSubviews()
        }
    }
    
//    private func configAnimationPopupThanks() {
//
//        var animationViewThanks = LottieAnimationView()
//        animationViewThanks = LottieAnimationView(name: Constants.Animations.CongratulationsAnimation)
//        animationViewThanks.loopMode = .loop
//        animationViewThanks.contentMode = .scaleAspectFill
//        animationViewThanks.animationSpeed = 1.0
//        animationViewThanks.play()
//        vwPopupThanks.addSubview(animationViewThanks)
//
//        animationViewThanks.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            animationViewThanks.topAnchor.constraint(equalTo: vwPopupThanks.topAnchor, constant: 30),
//            animationViewThanks.leadingAnchor.constraint(equalTo: vwPopupThanks.leadingAnchor, constant: 30),
//            animationViewThanks.trailingAnchor.constraint(equalTo: vwPopupThanks.trailingAnchor, constant: -30),
//            animationViewThanks.bottomAnchor.constraint(equalTo: btnSeeMoodData.topAnchor, constant: -10)
//            ])
//    }
    
    private func configNavBar() {
        
        self.navigationController?.navigationBar.alpha = 1
        self.navigationItem.title = Constants.Messages.Recipe
        self.navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor.yellowColor()]
        
        let backBtn = UIButton()
        backBtn.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        backBtn.setImage(UIImage(named: Constants.Images.LeftButton), for: .normal)
        backBtn.imageView?.image = backBtn.imageView?.image?.withTintColor(UIColor.yellowColor())
        backBtn.addTarget(self, action: #selector(self.dismissView), for: .touchUpInside)
        backBtn.widthAnchor.constraint(equalToConstant: 25).isActive = true
        backBtn.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        let backBarBtn = UIBarButtonItem(customView: backBtn)
        
        self.navigationItem.leftBarButtonItem = backBarBtn
    }
    
    private func configTextView() {
        
        showLoading(false)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        self.textViewRecipe.delegate = self
        self.textViewRecipe.layer.cornerRadius = 12
        self.textViewRecipe.text = presenter.recipe
    }
    
    private func configLabels() {
        
        self.lblThanks.text = Constants.Messages.Thanks
        self.btnSeeMoodData.setTitle(Constants.Messages.SeeDataMood, for: .normal)
        self.btnExit.setTitle(Constants.Messages.Exit, for: .normal)
    }
    
    private func showLoading(_ loading: Bool) {
        
        if loading {
            actLoading.startAnimating()
        }else {
            actLoading.stopAnimating()
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func dismissView() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    //-----------------------------------------------------------------------
    // MARK: RecipePresenterDelegate
    //-----------------------------------------------------------------------
    
    func showCongratulations() {
        self.showAnimationVwThanks()
    }
    
    func showError(_ strError: String) {}
    
    //-----------------------------------------------------------------------
    // MARK: -@IBAction Actions buttons
    //-----------------------------------------------------------------------

    @IBAction func saveMood(_ sender: Any) {
        presenter.saveMood()
    }
    
    @IBAction func seeMoodData(_ sender: Any) {}
    
    @IBAction func exit(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
