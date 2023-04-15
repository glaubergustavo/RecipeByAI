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
    
    // MARK: -@IBOutlet ScrollView
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var actLoading: UIActivityIndicatorView!
    
    // MARK: -@IBOutlet Recipe Title
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
        configNavBar()
        configTextView()
    }
    
    private func configRecipeTitle() {
        presenter.configRecipeTitle()
    }
    
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
    
    func showError(_ strError: String) {}
    
}
