//
//  ViewController.swift
//  Playlist
//
//  Created by admin on 27/08/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import MediaPlayer
import AVFoundation

class ViewController: UIViewController,MPMediaPickerControllerDelegate  {
    
    //Outlet por que este botao sera tanto para play e pause
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let mediaPicker = MPMediaPickerController(mediaTypes: .Music)
        mediaPicker.delegate = self
        presentViewController(mediaPicker, animated: true, completion: {})
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mediaPicker(mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        
        //User selected a/an item(s).
        for mpMediaItem in mediaItemCollection.items {
            print("Add \(mpMediaItem) to a playlist, prep the player, etc.")
        }
    }
    
    func mediaPickerDidCancel(mediaPicker: MPMediaPickerController) {        self.navigationController?.popViewControllerAnimated(true)
    }
    

}

