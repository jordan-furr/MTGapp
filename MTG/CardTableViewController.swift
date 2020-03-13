//
//  CardTableViewController.swift
//  MTG
//
//  Created by Jordan Furr on 3/12/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class CardTableViewController: UITableViewController {

    var page = 0
    var isFinalPage = false
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCards()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CardController.shared.cards.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath) as? CardTableViewCell else { return UITableViewCell()}
        let card = CardController.shared.cards[indexPath.row]
        cell.setCard(card: card)
        return cell
    }
    
    //MARK: - Helper
    func fetchCards() {
        guard !isFinalPage else {return}
        CardController.shared.getDeck(page: page) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                case .success(let cards):
                    self.tableView.reloadData()
                    if cards.count < 100 {
                        self.isFinalPage = true
                    } else {
                        self.page += 1
                    }
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        183.0
    }
}
