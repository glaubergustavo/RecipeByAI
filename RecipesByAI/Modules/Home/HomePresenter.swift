//
//  HomePresenter.swift
//  RickAndMortyApp
//
//  Created by Glauber Gustavo on 11/03/23.
//

import Foundation
import UIKit
import OpenAISwift

protocol HomePresenterDelegate: AnyObject {
    func dataLoaded()
    func showLoading(_ loading: Bool)
    func showNotFoundMessage()
}

final class HomePresenter {
    
    var recipe: String = Constants.Messages.Empty
    var selectedIngredients: [String] = []
    var arrayOfDicOfIngredients: [[String : String]] = [[:]]
    
    var delegate: HomePresenterDelegate?
    
    func loadData() {
        
        delegate?.showLoading(true)
        
        let selectedIngredients = self.selectedIngredients.dropLast().joined(separator: Constants.Messages.Comma) + Constants.Messages.And + self.selectedIngredients.last!
        
        HomeManager().loadData(ingredients: selectedIngredients) { result in
            
            self.delegate?.showLoading(false)
            
            switch result {
                case .success(let success):
                    print(success)
                    self.recipe = success
                    self.delegate?.dataLoaded()
                case .failure(let failure):
                    print(failure.localizedDescription)
            }
        }
    }
    
    func showRecipe(nav: UINavigationController, text: String) {
        HomeRouter().showRecipe(nav: nav, text: text)
    }
}
