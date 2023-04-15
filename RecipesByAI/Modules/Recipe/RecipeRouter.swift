//
//  MyMoodRouterSwift.swift
//  Victory Health
//
//  Created by Glauber Gustavo on 25/02/23.
//  Copyright © 2023 MadeinWeb. All rights reserved.
//

import UIKit

@objc class RecipeRouter: NSObject {
    
    var viewController: UIViewController!
    var storyboard: UIStoryboard!
    
    override init() {

        storyboard = UIStoryboard(name: Constants.Storyboards.Recipe, bundle: nil)

        if let controller = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboards.RecipeView) as? RecipeViewController {
            
            let presenter = RecipePresenter(delegate: controller)
            
            controller.presenter = presenter
            
            self.viewController = controller
        }
    }
    
    func show(nav: UINavigationController, text: String) {
       (self.viewController as? RecipeViewController)?.presenter.recipe = text
       nav.pushViewController(self.viewController, animated: true)
    }
}
