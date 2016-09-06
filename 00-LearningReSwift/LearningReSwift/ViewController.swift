//
//  ViewController.swift
//  LearningReSwift
//
//  Created by Or on 29/08/2016.
//  Copyright © 2016 Or. All rights reserved.
//

import UIKit
import ReSwift
class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.editing = true
        
        // Do any additional setup after loading the view, typically from a nib.
        mainStore.subscribe(self)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingEnd(textField: UITextField) {
        
        mainStore.dispatch(
            AddTask(task:textField.text!,isTypedAction:true)
        )
        
        textField.text = ""
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, shouldIndentWhileEditingRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .None
    }
}
extension ViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainStore.state.tasklist.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RegularCell", forIndexPath: indexPath) as! RegularCell
        cell.smallText!.text = mainStore.state.tasklist[indexPath.row]
        return cell
    }
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        print("moved")
    }
    
}

extension ViewController: StoreSubscriber {
    func newState(state: AppState) {
        self.tableView.reloadData()
        print(state.tasklist)
    }
}
