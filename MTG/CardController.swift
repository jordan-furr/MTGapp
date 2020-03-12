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
        urlComponents?.queryItems = [URLQueryItem(name: rarityQuery, value: "Mythic")]
        guard let finalURL = urlComponents?.url else { return completion(.failure(.invalidURL))}
        
        var request = URLRequest(url: finalURL)
        request.setValue(contentTypeValue, forHTTPHeaderField: contentTypeKey)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print(error,error.localizedDescription)
                return completion(.failure(.thrown(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData))}
            do {
                let cards = try JSONDecoder().decode([Card].self, from: data)
                self.cards = cards
                return completion(.success(cards))
            } catch {
                print(error, error.localizedDescription)
                return completion(.failure(.thrown(error)))
            }
        }.resume()
    }
    
    func getCard(card: Card, completion: @escaping (Result<Card, CardError>) -> Void ){
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL))}
        let id = card.id
        
        let cardsURL = baseURL.appendingPathComponent(cardsEndpoint)
        let finalURL = cardsURL.appendingPathComponent(id)
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print(error,error.localizedDescription)
                return completion(.failure(.thrown(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData))}
            
            //decode
            do {
                let responseArray = try JSONDecoder().decode([Card].self, from: data)
                guard let card = responseArray.first else { return completion(.failure(.noData))}
                return completion(.success(card))
            } catch {
                print(error, error.localizedDescription)
                return completion(.failure(.thrown(error)))
            }
        }.resume()
    }
}
