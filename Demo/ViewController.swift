//
//  ViewController.swift
//  Demo
//
//  Created by Sjors Provoost on 02-08-14.
//  Copyright (c) 2014 Crypto Coin Swift. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var progress: UIActivityIndicatorView!
    @IBOutlet weak var progressLabel: UILabel!
    
    @IBOutlet weak var addressHeader: UILabel!
    @IBOutlet weak var privateKeyHeader: UILabel!
    
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var privateKey: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH, 0), {
            println("Generating random Bitcoin address and key. Please be patient.")
            
            let bitcoin = CoinKey()
            let wif = bitcoin.wif
            println("Private key:" + wif)
            
            dispatch_async(dispatch_get_main_queue(), {
                self.privateKeyHeader.hidden = false
                self.privateKey.hidden = false

                self.privateKey.text = wif

                self.progress.startAnimating()
                
            })
            
            let startTime = NSDate()
            
            let address = bitcoin.publicAddress
            println("Address:" + address)
            
            let duration = -startTime.timeIntervalSinceNow
            
            println("Address generated in \(duration) seconds")

            dispatch_async(dispatch_get_main_queue(), {
                self.progress.stopAnimating()
                
                self.addressHeader.hidden = false
                self.address.hidden = false
                
                self.address.text = address

                self.progressLabel.text = "Here's your address and private key"
            })
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

