//
//  ViewController.swift
//  Contacts
//
//  Created by olzhs on 17.01.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    @IBAction func showNewCon(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Create new contact", message: "Enter name and phone", preferredStyle: .alert)
        alertController.addTextField { textField in textField.placeholder = "Name"
        }
        
        alertController.addTextField { textField in textField.placeholder = "Phone number"
        }
        
        let createButton = UIAlertAction(title: "Create", style: .default) { _ in
            guard let contactName = alertController.textFields?[0].text, let contactPhone = alertController.textFields?[1].text else {
                return
            }
            let contact = Contact(title: contactName, phone: contactPhone)
            self.contacts.append(contact)
            self.tableView.reloadData()
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(createButton)
        alertController.addAction(cancelButton)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadContacts()
    }

    private var contacts: [ContactProtocol] = [] {
        didSet {
            contacts.sort { $0.title < $1.title }
        }
    }
    
    private func loadContacts() {
        contacts.append(Contact(title: "David Copperfield", phone: "+799912312323"))
        contacts.append(Contact(title: "Bob Marley", phone: "+799911122233"))
        contacts.append(Contact(title: "Duke Motris", phone: "+791122255544"))
        
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell
        if let  reuseCell = tableView.dequeueReusableCell(withIdentifier: "MyCell") {
            print("Создаем новую ячейку для строки с индексом \(indexPath.row)")
        
        
        var newCell = UITableViewCell(style: .default, reuseIdentifier: "MyCell")
        configure(cell: &newCell, for: indexPath)
        
        cell = reuseCell
        } else {
        print("Используем старую ячейку для строки с индексом \(indexPath.row)")
            cell = UITableViewCell(style: .default, reuseIdentifier: "MyCell")
        }
        configure(cell: &cell, for: indexPath)
        return cell
    
    }
    
    private func configure(cell: inout UITableViewCell, for indexPath: IndexPath) {
        var configuration = cell.defaultContentConfiguration()
        configuration.text = contacts[indexPath.row].title
        configuration.secondaryText = contacts[indexPath.row].phone
        cell.contentConfiguration = configuration
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let actionDelete = UIContextualAction(style: .destructive, title: "Delete") {_,_,_ in
            self.contacts.remove(at: indexPath.row)
            tableView.reloadData()
        }
        
        let actions = UISwipeActionsConfiguration(actions: [actionDelete])
        return actions
        
    }
    
}

