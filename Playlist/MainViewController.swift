//
//  MainViewController.swift
//  Playlist
//
//  Created by admin on 28/08/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import MediaPlayer
import AVFoundation

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,MPMediaPickerControllerDelegate {
    
    @IBOutlet weak var tvMusicas: UITableView!
    @IBOutlet weak var viewPlayer: UIView!
    
    @IBOutlet weak var PlayPause: UIButton!
    
    var cadastro = Cadastro()
    
    
    // MARK: - Persistencia em arquivos
    func path() -> String {
        return NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
    }
    
    func arquivo() -> String {
        return "\(self.path())/arquivo"
    }
    
    // MARK: - Musica
    var musica = Musica()
    
    var ButtonAudioURL = NSURL()
    
    var ButtonAudioPlayer = AVAudioPlayer()  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tvMusicas.dataSource = self
        self.tvMusicas.delegate = self
        
        
        self.cadastro = Cadastro()
        
        
    }
    
    //MARK: - MUSICA
    
    @IBAction func pickMedia(sender: AnyObject) {            let mediaPicker = MPMediaPickerController(mediaTypes: .Music)
            mediaPicker.delegate = self
            presentViewController(mediaPicker, animated: true, completion: {})
    }
    
    func mediaPicker(mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        
        //User selected a/an item(s).
        for mpMediaItem in mediaItemCollection.items {
            print("Add \(mpMediaItem) to a playlist, prep the player, etc.")
            //self.musica = mpMediaItem
        }
    }
    
    func mediaPickerDidCancel(mediaPicker: MPMediaPickerController) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onTapPlayAudio(sender: UIButton) {
        self.musica = cadastro.get(sender.tag)
        self.PlayAudio1(self.musica)
    }
    
    func PlayAudio1(musica: Musica) {
        do {
            
            ButtonAudioURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(musica.description, ofType: musica.fileExtension)!)
            try ButtonAudioPlayer = AVAudioPlayer(contentsOfURL: ButtonAudioURL)
        } catch{
            print(error)
        }
        
        ButtonAudioPlayer.play()
    }
    
    @IBAction func Stop(sender: AnyObject) {
        ButtonAudioPlayer.stop()
        ButtonAudioPlayer.currentTime = 0
        PlayPause.setTitle("Play", forState: UIControlState.Normal)
    }
    
    
    @IBAction func Restart(sender: AnyObject) {
        ButtonAudioPlayer.stop()
        ButtonAudioPlayer.currentTime = 0
        ButtonAudioPlayer.play()
        
    }
    
    @IBAction func PausePlay(sender: AnyObject) {
        if (ButtonAudioPlayer.playing == true){
            ButtonAudioPlayer.stop()
            PlayPause.setTitle("Play", forState:UIControlState.Normal)
        }
        else {
            ButtonAudioPlayer.play()
            PlayPause.setTitle("Pause", forState:UIControlState.Normal)
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cadastro.quantidade()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tvMusicas.dequeueReusableCellWithIdentifier("celula", forIndexPath: indexPath) as! CelulaTableViewCell
        
        cell.musica = self.cadastro.get(indexPath.row)
        
        cell.lbNome.text = cell.musica.nome
        
        cell.PlayAudio.tag = indexPath.row
        
        cell.PlayAudio.addTarget(self, action: #selector(MainViewController.onTapPlayAudio), forControlEvents: .TouchUpInside)
        
        return cell;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //if (segue.identifier == "add_musica"){
        //    let view = segue.destinationViewController as! ViewController
        //}
    }
}