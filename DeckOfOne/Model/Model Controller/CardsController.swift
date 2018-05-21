//
//  CardsController.swift
//  DeckOfOne
//
//  Created by Caston  Boyd on 5/21/18.
//  Copyright © 2018 Caston  Boyd. All rights reserved.
//

import Foundation
import UIKit

//Step 1: URL
//Step 2: Request
//Step 3: URLSessionDatatask + RESUME
//Step 4: Decode Data into model objects

class CardController {
    
    static let baseURL = URL(string: "https://deckofcardsapi.com/api/deck/new/draw")
    
    static func draw(numberOfCards: Int, completion: @escaping (([Card]?) -> Void )){
       
        //Step 1: URL
        guard let url = baseURL else { completion(nil) ; return }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        // Create the Query
        let cardCountQuery = URLQueryItem(name: "count", value: "\(numberOfCards)")
        // Add Query to components
        components?.queryItems = [cardCountQuery]
        guard let urlWithQuery = components?.url else {
            completion(nil)
            return
        }
        print("working network: \(urlWithQuery.absoluteString) ")
        
        
        //Step 2: Request
        var request = URLRequest(url: urlWithQuery)
        request.httpMethod = "GET"
        request.httpBody = nil
        
        //Step 3: URLSessionDatatask + RESUME
        
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            //Decode data into model objects
            if let error = error {
                print("Error Decoding Data with dataTask: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else { completion(nil) ; return }
            let jsonDecoder = JSONDecoder()
            do {
                let cards = try jsonDecoder.decode(Cards.self, from: data)
                let arrayOfCards = cards.cards
                completion(arrayOfCards)
            }catch let error {
                print(error)
                
            }
        
            
            
        }.resume()
        
}

static func fetchImage(withUrlString: String, completion: @escaping ((UIImage?) -> Void)) {
    
    // URL
    guard let url = URL(string: withUrlString) else { completion(nil) ; return }
    
    // Request
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.httpBody = nil
    
    // DataTask + Resume + Decode
    URLSession.shared.dataTask(with: request) { (data, _, error) in
    if let error = error {
        print("Error with DataTask downloading image: \(error.localizedDescription)")
        completion(nil)
        return
    }
        guard let data = data,
            let image = UIImage(data: data) else { completion(nil) ; return }
            completion(image)
}.resume()

}
}



