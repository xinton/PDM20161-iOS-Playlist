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
    var ButtonAudioURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("punch", ofType: "wav")!)
    
    var ButtonAudioPlayer = AVAudioPlayer()
    
    
    var BackgroundAudio = try! AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("grenade", ofType: "wav")!))
    
    
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
        do {
            try ButtonAudioPlayer = AVAudioPlayer(contentsOfURL: ButtonAudioURL)
        } catch{
            print(error)
        }
        
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
    
    @IBAction func PlayAudio1() {
        BackgroundAudio.play()
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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cadastro.quantidade()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tvMusicas.dequeueReusableCellWithIdentifier("celula", forIndexPath: indexPath) as! CelulaTableViewCell
        
        cell.textLabel?.text = self.cadastro.get(indexPath.row).nome
        
        cell.PlayAudio.tag = indexPath.row
        
        cell.PlayAudio.addTarget(self, action: #selector(MainViewController.PlayAudio1), forControlEvents: .TouchUpInside)
        
        return cell;
    }
}