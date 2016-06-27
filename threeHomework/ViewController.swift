//
//  ViewController.swift
//  threeHomework
//
//  Created by Kyle on 2016/6/26.
//  Copyright © 2016年 Alphacamp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var Label1: UILabel!
    @IBOutlet weak var Label2: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var progressBar: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func webButton(sender: AnyObject) {    
    let url = NSURL(string: "https://www.youtube.com/watch?v=eNmL4JiGxZQ")
        UIApplication.sharedApplication().openURL(url!)
    }
    @IBAction func loadPicture(sender: AnyObject) {
     
        let urlString = "http://www.masterhands.com.tw/upload/201506290827302800/201506290827302801.jpg"
        
        let encodeUrl = urlString.stringByAddingPercentEncodingWithAllowedCharacters( NSCharacterSet.URLQueryAllowedCharacterSet())
        let url = NSURL(string: encodeUrl!)
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: self, delegateQueue: NSOperationQueue.mainQueue())
        let task = session.downloadTaskWithURL(url!)
        task.resume()
    }
}


extension ViewController: NSURLSessionDownloadDelegate {
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
        let data: NSData = NSData(contentsOfURL: location)!
        if data.length > 0 {
            let myImage = UIImage(data: data)
            imageView.image = myImage
            
        }
    }

    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        progressBar.progress = 1.0 * Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        Label1.text = "\(totalBytesWritten)bytes"
        Label2.text  = "\(totalBytesExpectedToWrite)bytes"
        
    }
}

