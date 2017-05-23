# Pokedexter App

- This application leverages PokeAPI

- With this app you will get all the information on 718 Pokemon you want.
They will even show you some cool moves.

- This app leverages AVFoundation for audio and UIKit Dynamics for physics

## Sample Pokemon Model
```
class Pokemon {
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _speed: String!
    private var _height: String!
    private var _weight: String!
    private var _health: String!
    private var _attack: String!
    private var _evolutionText: String!
    private var _evolvedId: String!
    private var _pokemonURL: String!
    private var _alreadyLoaded: Bool = false

    var name: String {
        if _name == nil {
            _name = ""
        }
        return _name
    }

    var pokedexId: Int {
        if _pokedexId == nil {
            _pokedexId = 1
        }
        return _pokedexId
    }

    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }

    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }

    var speed: String {
        if _speed == nil {
            _speed = ""
        }
        return _speed
    }

    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }

    var health: String {
        if _health == nil {
            _health = ""
        }
        return _health
    }

    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }

    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }

    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }

    var evolutionText: String {
        if _evolutionText == nil {
            _evolutionText = ""
        }
        return _evolutionText
    }

    var evolvedId: String {
        if _evolvedId == nil {
            _evolvedId = ""
        }
        return _evolvedId
    }


    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        self._type = ""

        self._pokemonURL = "\(BASE_URL)\(POKEMON_URI)\(self._pokedexId!)/"
    }

    func downloadDetails(completed: @escaping DownloadComplete) {
        if _alreadyLoaded {
            completed()
            return
        }
        Alamofire.request(_pokemonURL).responseJSON { (response) in
            if let pokeDictionary = response.result.value as? Dictionary<String, AnyObject> {

                if let def = pokeDictionary["defense"] as? Int {
                    self._defense = "\(def)"
                }

                if let speed = pokeDictionary["speed"] as? Int {
                    self._speed = "\(speed)"
                }

                if let height = pokeDictionary["height"] as? String {
                    self._height = height
                }

                if let weight = pokeDictionary["weight"] as? String {
                    self._weight = weight
                }

                if let health = pokeDictionary["hp"] as? Int {
                    self._health = "\(health)"
                }

                if let attack = pokeDictionary["attack"] as? Int {
                    self._attack = "\(attack)"
                }

                if let types = pokeDictionary["types"] as? [Dictionary<String, AnyObject>], types.count > 0 {
                    for type in types {
                        self._type = self._type == "" ? "\((type["name"] as? String)!.capitalized)"
                            : "\(self._type!)/\((type["name"] as? String)!.capitalized)"

                    }
                }

                if let evolution = pokeDictionary["evolutions"] as? [Dictionary<String, AnyObject>], evolution.count > 0 {

                    if let evolutionLevel = evolution[0]["level"] as? Int {

                        if let evolutionTo = evolution[0]["to"] as? String {

                            self._evolutionText = "Next Evolution: \(evolutionTo) @ LVL \(evolutionLevel)"

                        }

                        if let uri = evolution[0]["resource_uri"] as? String {
                            let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                            let evolId = newStr.replacingOccurrences(of: "/", with: "")
                            self._evolvedId = evolId
                        }

                    } else if evolution[0]["method"] != nil && evolution[0]["detail"] == nil
                        && evolution[0]["method"] as? String == "stone" {
                        self._evolutionText = "Next Evolution: \(String(describing: evolution[0]["to"]!)) /w \(String(describing: evolution[0]["method"]!))"

                        if let uri = evolution[0]["resource_uri"] as? String {
                            let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                            let evolId = newStr.replacingOccurrences(of: "/", with: "")
                            self._evolvedId = evolId
                        }

                    } else {
                        self._evolutionText = "Final Evolution"
                        self._evolvedId = "none"
                    }

                } else {
                    self._evolutionText = "Final Evolution"
                    self._evolvedId = "none"
                }

                if let descriptionDict = pokeDictionary["descriptions"] as? [Dictionary<String, AnyObject>], descriptionDict.count > 0 {
                    if let descriptionURI = descriptionDict[0]["resource_uri"]{

                        let url = "\(BASE_URL)\(descriptionURI)"

                        Alamofire.request(url).responseJSON(completionHandler: { (response) in
                            if let dict = response.result.value! as? Dictionary<String, AnyObject> {

                                if let description = dict["description"] as? String {
                                    let newDescription = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                    self._description = newDescription
                                }
                            }
                            completed()
                        })
                    }
                } else {
                    self._description = ""
                }
            }
            self._alreadyLoaded = true
            completed()
        }

    }


}
```

## Youtube Video
[![Video](https://img.youtube.com/vi/Kr78lD36W5w/0.jpg)](https://www.youtube.com/watch?v=Kr78lD36W5w)

*EricDev 2017
