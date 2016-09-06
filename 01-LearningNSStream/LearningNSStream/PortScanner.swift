//
//  PortScanned.swift
//  LearningNSStream
//
//  Created by Or on 06/09/2016.
//  Copyright © 2016 Or. All rights reserved.
//

import Foundation
import UIKit
class PortScanner: NSObject {
    
    var addrString:String
    var serverAdd: CFString
    var port: UInt32
    
    let complition:()->()
    
    var inputStream:NSInputStream!
    var outputStream:NSOutputStream!
    
    var status = "Scanning..."
    
    init(addr:String,aPort:String,aComplition:()->()) {
        
        serverAdd = addr as CFString
        port = UInt32(Int(aPort)!)
        complition = aComplition
        addrString = "\(addr):\(aPort)"
        super.init()
    }
    
    func scan() {
        //In order to work with network we must use a lower level API CFStream
        var readStream:  Unmanaged<CFReadStream>?
        var writeStream: Unmanaged<CFWriteStream>?
        
        
        
        CFStreamCreatePairWithSocketToHost(nil, serverAdd, port, &readStream, &writeStream)
        
        self.inputStream = readStream!.takeRetainedValue()
        self.outputStream = writeStream!.takeRetainedValue()
        
        self.inputStream.delegate = self
        self.outputStream.delegate = self
        
        self.inputStream.scheduleInRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
        self.outputStream.scheduleInRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
        
        self.inputStream.open()
        self.outputStream.open()
    }
}

extension PortScanner: NSStreamDelegate {
    func stream(aStream: NSStream, handleEvent eventCode: NSStreamEvent) {
        switch eventCode {
        case NSStreamEvent.OpenCompleted:
            print("OpenCompleted")
            if aStream is NSInputStream {
                dispatch_async(dispatch_get_main_queue(),{
                    self.sendMessage()
                })
            }
        case NSStreamEvent.HasBytesAvailable:
            print("HasBytesAvailable")
            if let input = aStream as? NSInputStream {
                var buffer = [UInt8](count: 4096, repeatedValue: 0)
                while (input.hasBytesAvailable){
                    let len = input.read(&buffer, maxLength: buffer.count)
                    if(len > 0){
                        let output = NSString(bytes: &buffer, length: buffer.count, encoding: NSUTF8StringEncoding)
                        if (output != ""){
                            status = String(output)
                            NSLog("server said: %@", output!)
                        }
                    }
                }
            }
        case NSStreamEvent.ErrorOccurred:
            status = "Port is closed"
            print("ErrorOccurred")
        case NSStreamEvent.EndEncountered:
            print("EndEncountered")
        default:
            print("default")
        }
        dispatch_async(dispatch_get_main_queue(),{
            self.complition()
        })
    }
    
    @IBAction func sendMessage() {
        let string = "000000000000000000000000000000\r\n"
        let data = string.dataUsingEncoding(NSASCIIStringEncoding)
        if let data = data {
            outputStream.write(UnsafePointer<UInt8>(data.bytes), maxLength: data.length)
        }
        
        
    }
}