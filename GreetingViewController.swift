//
//  GreetingViewController.swift
//  Multi-Lingo Greeting
//
//  Created by Audrey Li on 3/13/15.
//  Copyright (c) 2015 Shomigo. All rights reserved.
//

import UIKit
import AVFoundation

class GreetingViewController: UIViewController{

    @IBOutlet weak var appNameString: UILabel!
    @IBOutlet weak var greetingString: UILabel!
    @IBOutlet weak var dateString: UILabel!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var playBtn: UIButton!
    var player: AVAudioPlayer = AVAudioPlayer()
    var lanCount = 0
     var language = "en"
    
    
    @IBAction func playGreeting(sender: UIButton) {
        
        playGreeting()
    }
    
    func playGreeting(){
        var fileURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(language, ofType: "m4a")!)
        player = AVAudioPlayer(contentsOfURL: fileURL, error: nil)
        player.play()
    }

    @IBAction func switchLan(sender: UIButton) {
        lanCount = lanCount > 4 ? 0 : lanCount
        switch(lanCount){
            case 0: language = "en"  // --> fix language folder problem later
            case 1: language = "es"
            case 2: language = "fr-FR"
            case 3: language = "zh-Hans"
            case 4: language = "de"
            default: break
        }
        lanCount++
        setLanguage(language)
        playGreeting()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setLanguage("en")
       // setDefaultValue()

    }
    func setLanguage(language: String){
        var path = NSBundle.mainBundle().pathForResource(language, ofType: "lproj") ??  NSBundle.mainBundle().pathForResource("en", ofType: "lproj")
        let bundle = NSBundle(path: path!)
        
        appNameString.text = bundle?.localizedStringForKey("APP_NAME", value: "Swift Multilingo Greeting App", table: nil)
        greetingString.text = bundle?.localizedStringForKey("MY_GREETING", value: "Hello", table: nil)
        playBtn.setTitle(NSLocalizedString("PLAY_BTN_TEXT", comment: "Play button text"), forState: .Normal)
        
        dateString.text = dateFormatter.stringFromDate(NSDate())
        if let imageName = bundle?.localizedStringForKey("Image_Name",value: "bg", table: nil){
            bgImageView.image = UIImage(named: imageName)
        }
    }
    
    
    func setDefaultValue(){
        appNameString.text = NSLocalizedString("APP_NAME", comment: "App name")
        greetingString.text = NSLocalizedString("MY_GREETING", comment: "Greetings in another language")
        playBtn.setTitle(NSLocalizedString("PLAY_BTN_TEXT", comment: "Play button text"), forState: .Normal)
        dateString.text = dateFormatter.stringFromDate(NSDate())
        bgImageView.image = UIImage(named: NSLocalizedString("Image_Name",comment: "Just file name, no need to translate"))
    }
    
    // Use below formaters in future project 
    var numberFormatter: NSNumberFormatter {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .DecimalStyle
        return formatter
    }
    
    var currencyFormatter: NSNumberFormatter {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        return formatter
    }
    
    var dateFormatter: NSDateFormatter {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .MediumStyle
        return formatter
    }


}
