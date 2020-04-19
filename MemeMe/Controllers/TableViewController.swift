//
//  TableViewController.swift
//  MemeMe
//
//  Created by Rowan Hisham on 4/19/20.
//  Copyright © 2020 Rowan Hisham. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    // MARK: Read-Only access to the history array
    var memes: [Meme]! {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    // MARK: Enables editing the original history array
    var appDel: AppDelegate {
        return (UIApplication.shared.delegate as! AppDelegate)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Set number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    // MARK: fill cell with image and text
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableViewCell")!
        cell.textLabel?.text = memes[indexPath.row].topText
        cell.imageView?.image = memes[indexPath.row].originalImage
        cell.detailTextLabel?.text = memes[indexPath.row].topText + "..." + memes[indexPath.row].bottomText
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // MARK: Delete Entry on Swipe
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            tableView.beginUpdates()
            appDel.memes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.left )
            tableView.endUpdates()
        }
    }
}
