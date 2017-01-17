//
//  CoreDataHelp.swift
//  Pokemon
//
//  Created by Wendy Faulkner on 1/14/17.
//  Copyright © 2017 Leprechaun Skydiving. All rights reserved.
//

import UIKit
import CoreData

func addAllPokemon() {
    
    createPokemon(name:"Mew", imageName: "mew")
    createPokemon(name: "Meowth", imageName: "meowth")
    createPokemon(name: "Psyduck", imageName: "psyduck")
    createPokemon(name: "Rattata", imageName: "rattata")
    createPokemon(name: "Venonat", imageName: "venonat")
    createPokemon(name: "Zubat", imageName: "zubat")
    createPokemon(name: "Weedle", imageName: "weedle")
    createPokemon(name: "BellSprout", imageName: "bellsprout")
    createPokemon(name: "Bulbasaur", imageName: "bullbasaur")
    
    (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
}

func createPokemon(name: String, imageName: String) {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    let pokemon = Pokemon(context:context)
    pokemon.name = name
    pokemon.imageName = imageName
}

func getAllPokemon () -> [Pokemon] {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    do {
    let pokemons = try context.fetch(Pokemon.fetchRequest()) as! [Pokemon]
        
        if pokemons.count == 0 {
            addAllPokemon()
            return getAllPokemon()
        }
        
        
        return pokemons
    } catch {
        
    }
    
    
    return []
}

func getAllCaughtPokemons() -> [Pokemon] {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest = Pokemon.fetchRequest() as NSFetchRequest<Pokemon>
    
    fetchRequest.predicate = NSPredicate(format: "caught == %@", true as CVarArg)
   
    do {
        let pokemons = try context.fetch(fetchRequest) as [Pokemon]
        return pokemons
    } catch {
       return []
    }

    return []
}

func getAllUncaughtPokemons() -> [Pokemon] {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest = Pokemon.fetchRequest() as NSFetchRequest<Pokemon>
    fetchRequest.predicate = NSPredicate(format: "caught == %@", false as CVarArg)
    do {
        let pokemons = try context.fetch(fetchRequest) as [Pokemon]
        return pokemons
    } catch {
        return []
    }

  return []
}
