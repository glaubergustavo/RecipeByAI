//
//  HomeViewController.swift
//  RickAndMortyApp
//
//  Created by Glauber Gustavo on 11/03/23.
//

import UIKit

final class HomeViewController: UIViewController,
                          HomePresenterDelegate {
    
    
    // MARK: -@IBOutlet Motives Views
    @IBOutlet weak var vwBanana: UIView!
    @IBOutlet weak var vwOnion: UIView!
    @IBOutlet weak var vwSugar: UIView!
    @IBOutlet weak var vwMeat: UIView!
    @IBOutlet weak var vwRice: UIView!
    @IBOutlet weak var vwBean: UIView!
    @IBOutlet weak var vwCheese: UIView!
    @IBOutlet weak var vwEggs: UIView!
    @IBOutlet weak var vwTomato: UIView!
    @IBOutlet weak var vwChicken: UIView!
    @IBOutlet weak var vwNoodle: UIView!
    @IBOutlet weak var vwPotato: UIView!
    @IBOutlet weak var vwYam: UIView!
    @IBOutlet weak var vwLettuce: UIView!
    @IBOutlet weak var vwCreamyCheese: UIView!
    @IBOutlet weak var vwCarrot: UIView!
    @IBOutlet weak var vwFlour: UIView!
    @IBOutlet weak var vwButter: UIView!
    @IBOutlet weak var vwCoriander: UIView!
    @IBOutlet weak var vwMaizeStarch: UIView!
    @IBOutlet weak var vwTomatoExtract: UIView!
    @IBOutlet weak var vwHoney: UIView!
    @IBOutlet weak var vwChocolate: UIView!
    @IBOutlet weak var vwSweetenedCondensedMilk: UIView!
    @IBOutlet weak var vwBacon: UIView!
    @IBOutlet weak var vwOliveOil: UIView!
    @IBOutlet weak var vwSausage: UIView!
    @IBOutlet weak var vwParsley: UIView!
    @IBOutlet weak var vwCookies: UIView!
    @IBOutlet weak var vwStrawberry: UIView!
    @IBOutlet weak var vwCookingOil: UIView!
    @IBOutlet weak var vwLemon: UIView!
    @IBOutlet weak var vwFerment: UIView!
    @IBOutlet weak var vwCornFlakes: UIView!
    @IBOutlet weak var vwCassava: UIView!
    @IBOutlet weak var vwCoconut: UIView!
    @IBOutlet weak var vwCocoMilk: UIView!
    @IBOutlet weak var vwCorn: UIView!
    @IBOutlet weak var vwPeas: UIView!
    @IBOutlet weak var vwLentil: UIView!
    @IBOutlet weak var vwCassavaGum: UIView!
    @IBOutlet weak var vwPumpkin: UIView!
    @IBOutlet weak var vwSweetPotato: UIView!
    @IBOutlet weak var vwTuna: UIView!
    @IBOutlet weak var vwMushrooms: UIView!
    @IBOutlet weak var vwShrimp: UIView!
    @IBOutlet weak var vwSardine: UIView!
    @IBOutlet weak var vwChayote: UIView!
    @IBOutlet weak var actLoading: UIActivityIndicatorView!
    @IBOutlet weak var vwBackground: UIView!
    
    // MARK: Variables
    var checkboxImage: UIImageView!
    
    var presenter: HomePresenter!
    var centerYConstraint: NSLayoutConstraint?
    
    //-----------------------------------------------------------------------
    //  MARK: - Life Cycle
    //-----------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUI()
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        vwBackground.alpha = 0
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    //-----------------------------------------------------------------------
    //  MARK: - Custom Methods
    //-----------------------------------------------------------------------
    
    private func loadUI() {
        
        presenter.arrayOfDicOfViews = [[vwBanana:Constants.Messages.Banana], [vwOnion:Constants.Messages.Onion], [vwSugar:Constants.Messages.Sugar], [vwMeat:Constants.Messages.Meat], [vwRice:Constants.Messages.Rice], [vwBean:Constants.Messages.Bean], [vwCheese:Constants.Messages.Cheese], [vwEggs:Constants.Messages.Eggs], [vwTomato:Constants.Messages.Tomato], [vwChicken:Constants.Messages.Chicken], [vwNoodle:Constants.Messages.Noodle], [vwPotato:Constants.Messages.Potato], [vwYam:Constants.Messages.Yam], [vwLettuce:Constants.Messages.Lettuce], [vwCreamyCheese:Constants.Messages.CreamyCheese], [vwCarrot:Constants.Messages.Carrot], [vwFlour:Constants.Messages.Flour], [vwButter:Constants.Messages.Butter], [vwCoriander:Constants.Messages.Coriander], [vwMaizeStarch:Constants.Messages.MaizeStarch], [vwTomatoExtract:Constants.Messages.TomatoExtract], [vwHoney:Constants.Messages.Honey], [vwChocolate:Constants.Messages.Chocolate], [vwSweetenedCondensedMilk:Constants.Messages.SweetenedCondensedMilk], [vwBacon: Constants.Messages.Bacon], [vwOliveOil:Constants.Messages.OliveOil], [vwSausage:Constants.Messages.Sausage], [vwParsley:Constants.Messages.Parsley], [vwCookies:Constants.Messages.Cookies], [vwStrawberry:Constants.Messages.Strawberry], [vwCookingOil:Constants.Messages.CookingOil], [vwLemon:Constants.Messages.Lemon], [vwFerment:Constants.Messages.Ferment], [vwCornFlakes:Constants.Messages.CornFlakes], [vwCassava:Constants.Messages.Cassava], [vwCoconut:Constants.Messages.Coconut], [vwCocoMilk:Constants.Messages.CocoMilk], [vwCorn:Constants.Messages.Corn], [vwPeas:Constants.Messages.Peas], [vwLentil: Constants.Messages.Lentil], [vwCassavaGum:Constants.Messages.CassavaGum], [vwPumpkin:Constants.Messages.Pumpkin], [vwSweetPotato:Constants.Messages.SweetPotato], [vwTuna:Constants.Messages.Tuna], [vwMushrooms:Constants.Messages.Mushrooms], [vwShrimp:Constants.Messages.Shrimp], [vwSardine:Constants.Messages.Sardine], [vwChayote:Constants.Messages.Chayote]]
    }
    
    private func configUI() {

        showLoading(false)
        
        configIngredientsViews()
    }
    
    private func configIngredientsViews() {
        
        for dic in presenter.arrayOfDicOfViews {
            for (view, _) in dic {
                view.configViewAppearance()
                self.configCheckboxImage(view: view)
            }
        }
    }
    
    private func configCheckboxImage(view: UIView) {
        
        checkboxImage = UIImageView(image: UIImage(named: Constants.Images.iconCheckGreen))
        checkboxImage.frame = CGRect(x: 74, y: 6, width: 12, height: 12)
        checkboxImage.isHidden = true
        checkboxImage.tag = 1
        view.addSubview(checkboxImage)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func viewTapped(sender: UITapGestureRecognizer) {
        
        guard let view = sender.view else { return }
        
        for subview in view.subviews {
            
            if let imageView = subview as? UIImageView,
               imageView.tag == 1 {
                
                self.configAnimationsIngredients(view: view, imageView: imageView)
            }
        }
    }
    
    private func configAnimationsIngredients(view: UIView, imageView: UIImageView) {
        
        imageView.isHidden = !imageView.isHidden
        
        if imageView.isHidden {
            
            configSelectedIngredients(view: view, addIngredients: false)
            
            view.shadowAnimation(transform: CGAffineTransform.identity, size: CGSize(width: 0, height: 2))
        }else {
            
            configSelectedIngredients(view: view, addIngredients: true)
            
            view.shadowAnimation(transform: CGAffineTransform(scaleX: 0.9, y: 0.9), size: CGSize(width: 0, height: -5))
        }
    }
    
    private func configSelectedIngredients(view: UIView, addIngredients: Bool) {
        
        for dic in presenter.arrayOfDicOfViews {
            for (viewName, ingredients) in dic {
                if view == viewName {
                    if addIngredients {
                        presenter.selectedIngredients.append(ingredients)
                    }else {
                        if let index = presenter.selectedIngredients.firstIndex(of: ingredients) {
                            presenter.selectedIngredients.remove(at: index)
                        }
                    }
                }
            }
        }
    }
    
    private func ingredientAmountAlert() {
        
        let alertController = UIAlertController(title: Constants.Messages.Warning, message: Constants.Messages.ChooseIngredients, preferredStyle: .alert)

        let okAction = UIAlertAction(title: Constants.Messages.Ok, style: .default) { (action:UIAlertAction!) in
            self.dismiss(animated: true, completion: nil)
        }

        alertController.addAction(okAction)

        self.present(alertController, animated: true, completion:nil)
    }
    
    // MARK: - HomePresenterDelegate
    
    func dataLoaded() {
        presenter.showRecipe(nav: self.navigationController!, text: presenter.recipe)
    }
    
    func showLoading(_ loading: Bool) {
        
        if loading {
            UIView.animate(withDuration: 0.5) {
                self.actLoading.startAnimating()
                self.vwBackground.alpha = 0.7
            }
        }else {
            vwBackground.alpha = 0
            actLoading.stopAnimating()
        }
    }
    
    func showNotFoundMessage() {}
    
    // MARK: - Actions buttons
    
    
    @IBAction func getRecipe(_ sender: Any) {
        if presenter.selectedIngredients.count >= 3 {
            presenter.loadData()
        }else {
            ingredientAmountAlert()
        }
    }
    
}
