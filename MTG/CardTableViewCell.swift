//
//  CardTableViewCell.swift
//  MTG
//
//  Created by Jordan Furr on 3/12/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit


class CardTableViewCell: UITableViewCell {
    
    var card: Card?
    
    //MARK: IB Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    
    func setCard(card: Card){
        self.card = card
        updateUI()
    }
    
    @objc func updateUI(){
        guard let card = card else { return }
        nameLabel.text = card.name
        descriptionText.text = card.text
    }
}
