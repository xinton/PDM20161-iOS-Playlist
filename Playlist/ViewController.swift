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
    @IBOutlet weak var PlayPause: UIButton!
    
    
    
    var ButtonAudioURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("punch", ofType: "wav")!)
    
    var ButtonAudioPlayer = AVAudioPlayer()
    
    
    var BackgroundAudio = try! AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("grenade", ofType: "wav")!))
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        do {
            try ButtonAudioPlayer = AVAudioPlayer(contentsOfURL: ButtonAudioURL)
        } catch{
            print(error)
        }
        
        let mediaPicker = MPMediaPickerController(mediaTypes: .Music)
        mediaPicker.delegate = self
        presentViewController(mediaPicker, animated: true, completion: {})
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func PlayAudio1(sender: AnyObject) {
        ButtonAudioPlayer.play()
    }
    
    @IBAction func Stop(sender: AnyObject) {
        BackgroundAudio.stop()
        BackgroundAudio.currentTime = 0
        PlayPause.setTitle("Play", forState: UIControlState.Normal)
    }
    
    
    @IBAction func Restart(sender: AnyObject) {
        BackgroundAudio.stop()
        BackgroundAudio.currentTime = 0
        BackgroundAudio.play()
        
    }
    
    @IBAction func PausePlay(sender: AnyObject) {
        if (BackgroundAudio.playing == true){
            BackgroundAudio.stop()
            PlayPause.setTitle("Play", forState:UIControlState.Normal)
        }
        else {
            BackgroundAudio.play()
            PlayPause.setTitle("Pause", forState:UIControlState.Normal)
        }
    }
    
    @IBOutlet weak var pickSong: UIButton!
    
    func mediaPicker(mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        
        //User selected a/an item(s).
        for mpMediaItem in mediaItemCollection.items {
            print("Add \(mpMediaItem) to a playlist, prep the player, etc.")
        }
    }
    
    func mediaPickerDidCancel(mediaPicker: MPMediaPickerController) {
        print("User selected Cancel tell me what to do")
    }
    

}

