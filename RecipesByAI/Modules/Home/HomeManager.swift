//
//  HomeManager.swift
//  RickAndMortyApp
//
//  Created by Glauber Gustavo on 11/03/23.
//

import Foundation
import OpenAISwift

enum OpenAIError: Error {
    case missingChoiceText
    case apiError(Error)
}

final class HomeManager {
    
    var openAIModelType: OpenAIModelType = .gpt3(.davinci)
    var token: OpenAISwift?
    
    func loadData(ingredients: String, completion: @escaping (Result<String, OpenAIError>) -> Void) {
        token = OpenAISwift(authToken: Constants.API.authToken)
        
        let prompt = Constants.Messages.prompt
        
        token?.sendCompletion(with: prompt + ingredients, model: openAIModelType, maxTokens: 4000, completionHandler: { result in
            print(prompt + ingredients)
            DispatchQueue.main.async {
                switch result {
                    case .success(let model):
                        guard let text = model.choices?.first?.text else {
                            completion(.failure(.missingChoiceText))
                            return
                        }
                        completion(.success(text))
                    case .failure(let error):
                        completion(.failure(.apiError(error)))
                }
            }
        })
    }
}
