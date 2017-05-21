//
//  PokeDetailVC.swift
//  Pokedexter
//
//  Created by EricDev on 5/20/17.
//  Copyright © 2017 EricDev. All rights reserved.
//

import UIKit
import AVFoundation

class PokeDetailVC: UIViewController {
    
    var pokemon: Pokemon!
    var musicPlayer: AVAudioPlayer!

    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var pokemonDescriptionLabel: UILabel!
    @IBOutlet weak var pokemonTypeLabel: UILabel!
    @IBOutlet weak var pokemonDefenseLabel: UILabel!
    @IBOutlet weak var pokemonSpeedLabel: UILabel!
    @IBOutlet weak var pokemonHeightLabel: UILabel!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonHealthLabel: UILabel!
    @IBOutlet weak var pokemonWeightLabel: UILabel!
    @IBOutlet weak var pokemonAttackLabel: UILabel!
    @IBOutlet weak var evolutionLabel: UILabel!
    @IBOutlet weak var secondaryImage: UIImageView!
    @IBOutlet weak var evolutionImage: UIImageView!
    @IBOutlet weak var evolutionBar: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonNameLabel.text = pokemon.name.capitalized
        mainImage.layer.cornerRadius = 5.0
        evolutionBar.layer.cornerRadius = 5.0
        
        pokemon.downloadDetails {
            
            //code will be called after network call is complete
            self.updateUI()
        }
        
    }

    func updateUI(){
        mainImage.image = UIImage(named: "\(pokemon.pokedexId)")
        secondaryImage.image = mainImage.image
        
        pokemonDescriptionLabel.text = pokemon.description
        pokemonTypeLabel.text = pokemon.type
        pokemonDefenseLabel.text = pokemon.defense
        pokemonHeightLabel.text = pokemon.height
        pokemonIDLabel.text = "\(pokemon.pokedexId)"
        pokemonWeightLabel.text = pokemon.weight
        pokemonAttackLabel.text = pokemon.attack
        pokemonSpeedLabel.text = pokemon.speed
        pokemonHealthLabel.text = pokemon.health
        evolutionLabel.text = pokemon.evolutionText
        if pokemon.evolvedId == "none" {
            evolutionImage.isHidden = true
        } else {
            evolutionImage.isHidden = false
            evolutionImage.image = UIImage(named: pokemon.evolvedId)
        }
        evolutionImage.image = UIImage(named: pokemon.evolvedId)
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func musicButtonPressed(_ sender: UIButton) {
        if musicPlayer.isPlaying == true {
            musicPlayer.pause()
            sender.alpha = 0.3
        } else {
            musicPlayer.play()
            sender.alpha = 1
        }
    }
}
