//
//  CelulaTableViewCell.swift
//  Playlist
//
//  Created by admin on 28/08/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class CelulaTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbNome: UILabel!
    @IBOutlet weak var PlayAudio: UIButton!
    var musica: Musica!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
   // @IBAction func PlayAudio1(sender: AnyObject) {
   //     MainViewController().PlayAudio1(self.musica.description)
   // }
    
    /*override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if (selected == true){
            let alerta = UIAlertController(title: "Atenção", message: musica.nome, preferredStyle: UIAlertControllerStyle.Alert)
            
            alerta.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default
                , handler: nil))
            
            self.window?.rootViewController?.presentViewController(alerta, animated: true, completion: nil)
        }
    }*/
    
}
