//
//  MainViewController.swift
//  Playlist
//
//  Created by admin on 28/08/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import AVFoundation

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tfNome: UITextField!
    
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
    
    //var ButtonAudioURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("cheer", ofType: "wav")!)
    
    var ButtonAudioURL = NSURL()
    
    var ButtonAudioPlayer = AVAudioPlayer()
    
    
    //var BackgroundAudio = try! AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("grenade", ofType: "wav")!))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tvMusicas.dataSource = self
        self.tvMusicas.delegate = self
        
        let obj = NSKeyedUnarchiver.unarchiveObjectWithFile(self.arquivo())
        
        if (obj != nil){
            self.cadastro = obj as! Cadastro
        }else{
            self.cadastro = Cadastro()
        }
        
        // MARK: Musica
        //do {
        //    try ButtonAudioPlayer = AVAudioPlayer(contentsOfURL: ButtonAudioURL)
        //} catch{
        //    print(error)
        //}
        
        //BackgroundAudio.play()
        
    }
    
    // MARK: - Persistencia em arquivos
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        
        NSKeyedArchiver.archiveRootObject(self.cadastro, toFile: self.arquivo())
    }
    
    @IBAction func salvar(sender: AnyObject) {
        let nome = self.tfNome.text
        let p = Musica(nome: nome!)
        self.cadastro.add(p)
        self.tvMusicas.reloadData()
    }
    
    //MARK: - MUSICA
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onTapPlayAudio() {
        self.PlayAudio1(self.musica)
    }
    
    @IBAction func PlayAudio1(musica: Musica) {
        
        do {
            
            ButtonAudioURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(musica.description, ofType: "wav")!)
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
        
        //let musica:Musica! = self.cadastro.get(indexPath.row)
        self.musica = self.cadastro.get(indexPath.row)
        cell.textLabel?.text = musica.nome
        
        cell.PlayAudio.tag = indexPath.row
        
        cell.PlayAudio.addTarget(self, action: #selector(MainViewController.onTapPlayAudio), forControlEvents: .TouchUpInside)
        
        return cell;
    }
}