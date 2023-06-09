//
//  HomeRouter.swift
//  RickAndMortyApp
//
//  Created by Glauber Gustavo on 11/03/23.
//

import Foundation
import UIKit

final class HomeRouter {
    
    var storyboard: UIStoryboard!
    var viewController: UIViewController!
    
    init() {
        
        storyboard = UIStoryboard(name: Constants.Storyboards.Home, bundle: nil)
        
        if let controller = storyboard.instantiateViewController(withIdentifier: Constants.Storyboards.HomeView) as? HomeViewController {
            controller.presenter = HomePresenter()
            controller.presenter.delegate = controller
            viewController = controller
        }
    }
    
    func showRecipe(nav: UINavigationController, text: String) {
        RecipeRouter().show(nav: nav, text: text)
    }
    
}
