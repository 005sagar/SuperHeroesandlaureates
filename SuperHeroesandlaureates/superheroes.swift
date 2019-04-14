//
//  superhero.swift
//  Superheroes and Laureates
//
//  Created by Tiwari,Sagar on 4/11/19.
//  Copyright © 2019 Tiwari,Sagar. All rights reserved.
//

import Foundation
struct Superhero: Codable{
    var members: [Members]
    
}
struct Members: Codable{
    var name: String
    var secretIdentity: String
    var powers: [String]
}

struct Laureates: Codable{
    var firstname: String
    var surname: String
    var born: String
    var died: String
}

