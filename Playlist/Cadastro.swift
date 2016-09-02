//
//  Cadastro.swift
//  Musicas
//
//  Created by admin on 23/08/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation

class Cadastro: NSObject {
    var lista: Array<Musica>!
    
    override init() {
        self.lista = Array<Musica>()
        self.lista.append(Musica(nome: "punch",extensao:"wav"))
        self.lista.append(Musica(nome: "scratch",extensao:"wav"))
        self.lista.append(Musica(nome: "grenade",extensao:"wav"))
        self.lista.append(Musica(nome: "heartbeatenhanced",extensao:"wav"))
        self.lista.append(Musica(nome: "phoneringing",extensao:"mp3"))
        self.lista.append(Musica(nome: "cheer",extensao:"wav"))
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