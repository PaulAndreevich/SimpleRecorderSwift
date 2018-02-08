//
//  ViewController.swift
//  RecorderSwift
//
//  Created by Boss on 03/01/2018.
//  Copyright © 2018 Boss. All rights reserved.
//

import Cocoa

import AVFoundation
import AVKit

class ViewController: NSViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate, NSTableViewDataSource{

    @IBOutlet weak var startRecordingBTN: NSButton!
    @IBOutlet weak var stopRecordingBTN: NSButton!
    @IBOutlet weak var playRecordBTN: NSButton!
    @IBOutlet weak var stopPlayingBTN: NSButton!
    
    var soundRecorder : AVAudioRecorder!
    var soundPlayer : AVAudioPlayer!
    
    //let tableview: NSTableView!
    
    //var yourArray = [String](
    
    
    //let devices = AVCaptureDevice.devices(for: AVMediaType.audio)
   // var capdev : AVCaptureDevice
    
    var fileName = "audioFile.m4a"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRecorder()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func setupRecorder(){
        
        let recordSettings = [AVFormatIDKey: kAudioFormatAppleLossless,
                              AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue,
                              AVEncoderBitRateKey: 320000,
                              AVNumberOfChannelsKey: 2,
                              AVSampleRateKey: 44100.0 ] as [String : Any]
        
        //var error : NSError?
        
        let docDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = docDirURL.appendingPathComponent(fileName)
        
        soundRecorder = try! AVAudioRecorder.init(url: fileURL, settings: recordSettings)
        
        soundRecorder.delegate = self
        soundRecorder.prepareToRecord()
        
       /* if let err = error{
            NSLog("Something Wrong")
        }
        else {
            soundRecorder.delegate = self
            soundRecorder.prepareToRecord()
        }*/
    }
    
    func getCacheDirectory() -> String {
        
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true) as! [String]
        
        return paths[0]
    }
    
    func getFileURL() -> NSURL {
       
        //let path = (getCacheDirectory() as NSString).stringByAppendingPathComponent(fileName)
   
        let path = (getCacheDirectory() as NSString).appendingPathComponent(fileName)
        
        let filePath = NSURL(fileURLWithPath: path)
        
        return filePath
    }
    
    @IBAction func startRecording(_ sender: Any) {
        soundRecorder.record()
        startRecordingBTN.isEnabled = false
        playRecordBTN.isEnabled = false
        stopPlayingBTN.isEnabled = false
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        soundRecorder.stop()
        startRecordingBTN.isEnabled = true
        playRecordBTN.isEnabled = false
        //stopPlayingBTN.isEnabled = false
    }
    
    @IBAction func playRecord(_ sender: Any) {
        startRecordingBTN.isEnabled = false
        preparePlayer()
        soundPlayer.play()
        
    }
    @IBAction func stopPlaying(_ sender: Any) {
        stopPlayingBTN.isEnabled = false
    }
    
    func preparePlayer(){
        
        let docDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = docDirURL.appendingPathComponent(fileName)
        
        soundPlayer = try! AVAudioPlayer.init(contentsOf : fileURL)
        soundPlayer.delegate  = self
        soundPlayer.prepareToPlay()
        soundPlayer.volume = 1.0
        
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        playRecordBTN.isEnabled = true
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        startRecordingBTN.isEnabled = true
    }
    
    
    
    


    
}








