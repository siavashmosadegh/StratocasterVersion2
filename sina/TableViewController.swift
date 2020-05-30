//
//  TableViewController.swift
//  sina
//
//  Created by Siavash Mosadegh on 5/29/20.
//  Copyright © 2020 Siavash Mosadegh. All rights reserved.
//

import UIKit

class TableViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {
    
    var arrayOfSongs = [
        ["Farhad Mehrad - Jome",24]
        ,
        ["Shajarian - Morghe Sahar",19]
    ]

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    
    
    //MARK: - table view data source methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfSongs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        cell.textLabel?.text = arrayOfSongs[indexPath.row][0] as! String
        
        return cell
    }
    
    
    
    //MARK: - table view delegate methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToCollection", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! ViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.nameOfSong = arrayOfSongs[indexPath.row][0] as! String
            destinationVC.numberOfPictures = arrayOfSongs[indexPath.row][1] as! Int 
        }
        
    }
}
