//
//  PokeCell.swift
//  Pokedexter
//
//  Created by EricDev on 5/19/17.
//  Copyright © 2017 EricDev. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokeId: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    func configCell(_ pokemon: Pokemon){
        self.pokemon = pokemon
        self.pokeId.text = "#\(self.pokemon.pokedexId)"
        self.pokeImage.image = UIImage(named: "\(self.pokemon.pokedexId)")
        self.nameLabel.text = self.pokemon.name.capitalized
        
    }
    
}
