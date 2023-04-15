//
//  RecipePresenter.swift
//  Victory Health
//
//  Created by Glauber Gustavo on 26/02/23.
//  Copyright © 2023 MadeinWeb. All rights reserved.
//

import UIKit

protocol RecipePresenterDelegate {
    func showError(_ strError: String)
}

class RecipePresenter: NSObject {
    
    var recipe: String!
    var recipeTitle: String!
    
    var delegate: RecipePresenterDelegate?
    
    init (delegate: RecipePresenterDelegate?) {
        self.delegate = delegate
    }
    
    func configRecipeTitle() {
        
        guard let text = recipe, text != Constants.Messages.Empty else { return }
        guard let range = text.range(of: Constants.Messages.textConcatenation, options: .regularExpression) else { return }
        let title = String(text[range])
        recipeTitle = title
        let untitledText = text.replacingOccurrences(of: Constants.Messages.Name + title, with: Constants.Messages.Empty)
        recipe = untitledText
    }
}
