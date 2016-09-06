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
        
        //Subscribing for state changes
        mainStore.subscribe(self)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingEnd(textField: UITextField) {
        
        // calling an action to change the store
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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as! HeaderCell
        switch section {
        case 0:
            header.title.text = "Urgent"
        case 1:
            header.title.text = "Later"
        case 2:
            header.title.text = "Someday"
        default:
            break
        }
        return header
        
    }
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return mainStore.state.list[section].count

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RegularCell", forIndexPath: indexPath) as! RegularCell
        cell.smallText!.text = mainStore.state.list[indexPath.section][indexPath.row]
        return cell
    }
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        mainStore.dispatch (
            Reorder(index: sourceIndexPath, newIndex: destinationIndexPath)
        )
        
    }
    
}

extension ViewController: StoreSubscriber {
    func newState(state: AppState) {
        self.tableView.reloadData()
    }
}
