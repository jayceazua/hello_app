//
//  HelloTableViewController.swift
//  Hello_App
//
//  Created by Jayce Azua on 1/8/19.
//  Copyright © 2019 Jayce Azua. All rights reserved.
//

import UIKit

class HelloTableViewController: UITableViewController {
    
    var allHellos: [Hello] = []
    
    override func viewWillAppear(_ animated: Bool) {
        getHellos()
    }
    
    @IBAction func helloTapped(_ sender: Any) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let _ = Hello(context: context)
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            getHellos()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let hello = allHellos[indexPath.row]
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            context.delete(hello)
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            getHellos()
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allHellos.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let hello = allHellos[indexPath.row]
        cell.textLabel?.text = hello.title
        return cell
    }
    
    func getHellos() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let hellos = try? context.fetch(Hello.fetchRequest()) {
                if let theHellos = hellos as? [Hello]{
                    allHellos = theHellos
                    tableView.reloadData()
                }
            }
        }
    }
    
}
