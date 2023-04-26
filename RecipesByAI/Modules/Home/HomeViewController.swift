//
//  HomeViewController.swift
//  RickAndMortyApp
//
//  Created by Glauber Gustavo on 11/03/23.
//

import UIKit
import Lottie

final class HomeViewController: UIViewController,
                                HomePresenterDelegate,
                                IngredientsCellDelegate {
    
    
    // MARK: -@IBOutlet Views
    @IBOutlet weak var vwBackground: UIView!
    @IBOutlet weak var vwAnimationLoading: UIView!
    @IBOutlet weak var cvIngredients: UICollectionView!
    
    // MARK: Variables
    var animationView = LottieAnimationView()
    var presenter: HomePresenter!
    
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
        vwAnimationLoading.alpha = 0
    }
    
    //-----------------------------------------------------------------------
    //  MARK: - Custom Methods
    //-----------------------------------------------------------------------
    
    private func loadUI() {
        
        presenter.arrayOfDicOfIngredients = [
            [Constants.Images.Banana: Constants.Messages.Banana],
            [Constants.Images.Onion: Constants.Messages.Onion],
            [Constants.Images.Sugar: Constants.Messages.Sugar],
            [Constants.Images.Meat: Constants.Messages.Meat],
            [Constants.Images.Rice: Constants.Messages.Rice],
            [Constants.Images.Bean: Constants.Messages.Bean],
            [Constants.Images.Cheese: Constants.Messages.Cheese],
            [Constants.Images.Eggs: Constants.Messages.Eggs],
            [Constants.Images.Tomato: Constants.Messages.Tomato],
            [Constants.Images.Chicken: Constants.Messages.Chicken],
            [Constants.Images.Noodle: Constants.Messages.Noodle],
            [Constants.Images.Potato: Constants.Messages.Potato],
            [Constants.Images.Yam: Constants.Messages.Yam],
            [Constants.Images.Lettuce: Constants.Messages.Lettuce],
            [Constants.Images.CreamyCheese: Constants.Messages.CreamyCheese],
            [Constants.Images.Carrot: Constants.Messages.Carrot],
            [Constants.Images.Flour: Constants.Messages.Flour],
            [Constants.Images.Butter: Constants.Messages.Butter],
            [Constants.Images.Coriander: Constants.Messages.Coriander],
            [Constants.Images.MaizeStarch: Constants.Messages.MaizeStarch],
            [Constants.Images.TomatoExtract: Constants.Messages.TomatoExtract],
            [Constants.Images.Honey: Constants.Messages.Honey],
            [Constants.Images.Chocolate: Constants.Messages.Chocolate],
            [Constants.Images.SweetenedCondensedMilk: Constants.Messages.SweetenedCondensedMilk],
            [Constants.Images.Bacon: Constants.Messages.Bacon],
            [Constants.Images.OliveOil: Constants.Messages.OliveOil],
            [Constants.Images.Sausage: Constants.Messages.Sausage],
            [Constants.Images.Parsley: Constants.Messages.Parsley],
            [Constants.Images.Cookies: Constants.Messages.Cookies],
            [Constants.Images.Strawberry: Constants.Messages.Strawberry],
            [Constants.Images.CookingOil: Constants.Messages.CookingOil],
            [Constants.Images.Lemon: Constants.Messages.Lemon],
            [Constants.Images.Ferment: Constants.Messages.Ferment],
            [Constants.Images.CornFlakes: Constants.Messages.CornFlakes],
            [Constants.Images.Cassava: Constants.Messages.Cassava],
            [Constants.Images.Coconut: Constants.Messages.Coconut],
            [Constants.Images.CocoMilk: Constants.Messages.CocoMilk],
            [Constants.Images.Corn: Constants.Messages.Corn],
            [Constants.Images.Peas: Constants.Messages.Peas],
            [Constants.Images.Lentil: Constants.Messages.Lentil],
            [Constants.Images.CassavaGum: Constants.Messages.CassavaGum],
            [Constants.Images.Pumpkin: Constants.Messages.Pumpkin],
            [Constants.Images.SweetPotato: Constants.Messages.SweetPotato],
            [Constants.Images.Tuna: Constants.Messages.Tuna],
            [Constants.Images.Mushrooms: Constants.Messages.Mushrooms],
            [Constants.Images.Shrimp: Constants.Messages.Shrimp],
            [Constants.Images.Sardine: Constants.Messages.Sardine],
            [Constants.Images.Chayote: Constants.Messages.Chayote]
        ]

    }
    
    private func configUI() {
        cvIngredients.register(UINib(nibName: "IngredientsCell", bundle: Bundle.main), forCellWithReuseIdentifier: "IngredientsCell")
    }
    
    private func configAnimationLoading() {
        
        vwAnimationLoading.alpha = 1
        vwAnimationLoading.backgroundColor = .clear
        vwAnimationLoading.layer.cornerRadius = vwAnimationLoading.frame.height / 2
        animationView = LottieAnimationView(name: "120972-chef")
        animationView.loopMode = .loop
        animationView.contentMode = .scaleAspectFill
        animationView.frame = CGRect(x: -70, y: -100, width: 200, height: 200)
        animationView.animationSpeed = 1.0
        animationView.tintColor = UIColor.orange
        animationView.play()
        vwAnimationLoading.addSubview(animationView)

    }
    
    func configSelectedIngredients(view: UIView, addIngredients: Bool) {
        
        for subview in view.subviews {
            if let imageView = subview as? UIImageView, let currentImage = imageView.image {
                
                for dic in presenter.arrayOfDicOfIngredients {
                    
                    for (image, ingredient) in dic {
                        
                        if currentImage == UIImage(named: image) {
                            
                            if addIngredients {
                                presenter.selectedIngredients.append(ingredient)
                            }else {
                                if let index = presenter.selectedIngredients.firstIndex(of: ingredient) {
                                    presenter.selectedIngredients.remove(at: index)
                                }
                            }
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
                self.configAnimationLoading()
                self.vwBackground.alpha = 0.7
            }
        }else {
            vwBackground.alpha = 0
            animationView.stop()
            animationView.removeFromSuperview()
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

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width/4, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 15, bottom: 0, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.arrayOfDicOfIngredients.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IngredientsCell", for: indexPath) as! IngredientsCell
            
        let ingredient = presenter.arrayOfDicOfIngredients[indexPath.row]
        let ingredientImageName = ingredient.keys.first ?? ""
        let ingredientText = ingredient.values.first ?? ""
            
        cell.setIngredientImage(image: ingredientImageName)
        cell.setIngredientName(name: ingredientText)
        cell.delegate = self
            
        return cell
    }
    
}
