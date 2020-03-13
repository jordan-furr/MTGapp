//
//  CardController.swift
//  MTG
//
//  Created by Jordan Furr on 3/12/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import Foundation

class CardController {
    
    static let shared = CardController()
    var cards: [Card] = []
    private let baseURL = URL(string: "https://api.magicthegathering.io/v1/")
    private let cardsEndpoint = "cards"
    private let rarityQuery = "rarity"
    private let colorQuery = "colors"
    private let contentTypeKey = "Content-Type"
    private let contentTypeValue = "application/json"
    
    func getDeck(page: Int, completion: @escaping (Result<[Card],CardError>) -> Void ){
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL))}
        let cardsURL = baseURL.appendingPathComponent(cardsEndpoint)
        var urlComponents = URLComponents(url: cardsURL, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [URLQueryItem(name: rarityQuery, value: "mythic")]
        guard let finalURL = urlComponents?.url else { return completion(.failure(.invalidURL))}
        print(finalURL)
        
        var request = URLRequest(url: finalURL)
        request.setValue(contentTypeValue, forHTTPHeaderField: contentTypeKey)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print(error,error.localizedDescription)
                return completion(.failure(.thrown(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData))}
            do {
                let deck = try JSONDecoder().decode(Deck.self, from: data)
                let cards = deck.cards
                self.cards = cards
                return completion(.success(cards))
            } catch {
                print(error, error.localizedDescription)
                return completion(.failure(.thrown(error)))
            }
        }.resume()
    }
}
