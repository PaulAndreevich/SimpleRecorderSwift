//
//  ViewController.swift
//  RecorderSwift
//
//  Created by Boss on 03/01/2018.
//  Copyright © 2018 Boss. All rights reserved.
//

import Cocoa
//import AppKit
import AVFoundation
import AVKit

class ViewController: NSViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate, NSTableViewDataSource{

    @IBOutlet weak var startRecordingBTN: NSButton!
    @IBOutlet weak var stopRecordingBTN: NSButton!
    @IBOutlet weak var playRecordBTN: NSButton!
    @IBOutlet weak var stopPlayingBTN: NSButton!
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var CurrentDeviceLabel: NSTextFieldCell!
    
    
    var soundRecorder : AVAudioRecorder!
    var soundPlayer : AVAudioPlayer!
    var theSwitch: switchWrapperWrapper!
    var devices = [String]()
    
    
    //Table Datasource
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        //NSLog("did change")
    }
    
    override func awakeFromNib() {
        let clSelector:Selector = #selector(DoubleClick)
        tableView?.target = self
        tableView?.doubleAction = clSelector
    }
    
    @objc func DoubleClick(sender: AnyObject) {
        //NSLog("here")
        
       // var i: UInt8 = UInt8.init()!
       // let up: UnsafeMutablePointer<UInt8> = UnsafeMutablePointer<UInt8>.init(&i)
       // let down: UnsafeMutablePointer<UInt8>! = up;
        
        theSwitch.setDevice(devices[tableView.selectedRow])
        
        let currentMicName = String(cString: theSwitch.getCurrentInputDevice())
        
        if (currentMicName == devices[tableView.selectedRow]) {
            CurrentDeviceLabel.stringValue = currentMicName
        }
        //NSLog(devices[tableView.selectedRow])
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return devices.count
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        // NSLog("lol")
        return devices[row]
    }
    
    //let devices = AVCaptureDevice.devices(for: AVMediaType.audio)
    //var capdev : AVCaptureDevice
    
    var fileName = "audioFile.m4a"
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRecorder()
        theSwitch = switchWrapperWrapper()
        
        // setting the current mic
        let currentMicName = String(cString: theSwitch.getCurrentInputDevice())
        CurrentDeviceLabel.stringValue = currentMicName
        
        theSwitch.findAllInputDevices()
        theSwitch.initializeDeviceIterator()
        
        while(theSwitch.iteratorEnded() != true){
            devices.append(String(cString: theSwitch.value()));
            theSwitch.advanceDeviceIterator()
        }
        
        
        
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










