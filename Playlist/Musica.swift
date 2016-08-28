//
//  Musica.swift
//  Playlist
//
//  Created by admin on 28/08/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation

class Musica: NSObject {
    var nome:String?
    
    override var description: String{
        return self.nome!
    }
    
    init(nome:String) {
        self.nome = nome
    }
    
    override init() {
        super.init()
    }
    
}