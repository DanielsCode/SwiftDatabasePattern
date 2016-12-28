//
//  AthletsTVC.swift
//  DatabasePattern
//
//  Created by Daniel Siegel on 28.12.16.
//  Copyright © 2016 Daniel Siegel. All rights reserved.
//

import UIKit
import RealmSwift


class AthletsTVC: UITableViewController {
    
    let dataSource = AthletsCoreDataDataSource() // AthletsRealmDataSource()
    var athlets = [Athlet]()
    
    func fetchData() {
        athlets = dataSource.all()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchData()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return athlets.count > 0 ? 1 : 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return athlets.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "athletCell", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = athlets[indexPath.row].name
        
        return cell
    }
    
    // MARK: - Actions
    
    @IBAction func addBtnTouched(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "New Athlet", message: "Enter the name of the athlet", preferredStyle: .alert)
        var alertTextField: UITextField!
        alertController.addTextField { textField in
            alertTextField = textField
            textField.placeholder = "Athlet Name"
        }
        alertController.addAction(UIAlertAction(title: "Add", style: .default) { _ in
            guard let name = alertTextField.text , !name.isEmpty else { return }
            self.dataSource.insert(item: Athlet(withId: UUID().uuidString, name: name))
            self.fetchData()
            let newRowIndexPath = IndexPath(row: self.athlets.count-1, section: 0)
            self.tableView.insertRows(at: [newRowIndexPath], with: .automatic)
        })
        present(alertController, animated: true, completion: nil)
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            let athlet = athlets[indexPath.row]
            dataSource.delete(item: athlet)
            athlets.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showAthlet" {
            if let athletVC = segue.destination as? AthletVC, let index = tableView.indexPathForSelectedRow?.row {
                athletVC.athlet = athlets[index]
            }
            
        }
    }
    
}
