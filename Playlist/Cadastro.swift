//
//  Cadastro.swift
//  Nomes
//
//  Created by admin on 23/08/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation

class Cadastro: NSObject, NSCoding {
    var lista: Array<Musica>!
    
    override init() {
        self.lista = Array<Musica>()
        self.lista.append(Musica(nome: "punch"))        
        self.lista.append(Musica(nome: "scratch"))
        self.lista.append(Musica(nome: "grenade"))
        self.lista.append(Musica(nome: "heartbeatenhanced"))
        self.lista.append(Musica(nome: "phoneringing"))
        self.lista.append(Musica(nome: "cheer"))
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.lista = aDecoder.decodeObjectForKey("lista") as! Array<Musica>
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.lista, forKey: "lista")
    }
    
    func add(p:Musica) {
        self.lista.append(p)
    }
    
    func quantidade() -> Int {
        return self.lista.count
    }
    
    func get(index:Int) -> Musica {
        return self.lista[index]
    }
}