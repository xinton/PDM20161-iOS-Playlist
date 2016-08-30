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
    var extensao:String?
    
    override var description: String{
        return self.nome!
    }
    
    var fileExtension: String{
        return self.extensao!
    }
    
    init(nome:String,extensao:String) {
        self.nome = nome
        self.extensao = extensao
    }
    
    override init() {
        super.init()
    }
    
}