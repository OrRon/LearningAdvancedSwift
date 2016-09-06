//
//  ViewController.swift
//  LearningNSStream
//
//  Created by Or on 06/09/2016.
//  Copyright © 2016 Or. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var scanners:[PortScanner] = []
    
    @IBOutlet weak var addrText: UITextField!
    @IBOutlet weak var portText: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    //Declare 2 streams one for input and one for output
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onConnect()
    {
        let scanner = PortScanner(addr:self.addrText.text!,aPort:self.portText.text!) {
            
            self.tableView.reloadData()
            
        }
        scanner.scan()
        
        scanners.append(scanner)
        
        self.tableView.reloadData()
        
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scanners.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PortScannedCell", forIndexPath: indexPath) as! PortScannedCell
        let portScanner = scanners[indexPath.row]
        cell.address!.text = portScanner.addrString
        cell.outputText!.text = portScanner.status
        return cell
    }
}

