//
//  CardViewController.swift
//  DeckOfOne
//
//  Created by Caston  Boyd on 5/21/18.
//  Copyright © 2018 Caston  Boyd. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    @IBOutlet weak var cardImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
  
    @IBAction func drawButtonTapped(_ sender: Any) {
        CardController.draw(numberOfCards: 3) { (cards) in
            guard let firstCard = cards?.first else { return }
            CardController.fetchImage(withUrlString: firstCard.image, completion: { (image) in
                guard let image = image else { return }
                DispatchQueue.main.async {
                self.cardImageView.image = image
                }
            })
        }
        
    }
    
}
