//
//  ViewController.swift
//  Project7
//
//  Created by Adrimi on 01/07/2019.
//  Copyright © 2019 Adrimi. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
    var filteredPetitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Online data
        let urlString: String
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(creditsTapped))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchTapped))
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://hackingwithswift.com/samples/petitions-2.json"
        }
        
        
        // Convert to URL format
        if let url = URL(string: urlString) {
            // and then to Data format. Can fail if network is shut off. Will freeze thread until full fetch is comleted
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        } else {
            showError()
        }
    }
    
    @objc func searchTapped() {
        let ac = UIAlertController(title: "Enter words", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Search", style: .default) {
            [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.search(answer)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        ac.addAction(submitAction)
        ac.addAction(cancelAction)
        present(ac, animated: true)
    }
    
    func search(_ answer: String) {
        
        // If user have not provided any answer, head back to main "petitions" array
        if !answer.isEmpty {
            
            // search without worrying about cased words
            let lowerAnswer = answer.lowercased()
            for petition in petitions {
                if petition.title.lowercased().contains(lowerAnswer) {
                    filteredPetitions.append(petition)
                }
            }
        } else {
            filteredPetitions.removeAll()
        }

        // reload table
        tableView.reloadData()
    }
    
    @objc func creditsTapped() {
        let ac = UIAlertController(title: "Credits", message: "This application uses the data made available by We The People API of the Whitehouse", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem with loading the feed. Please check your connection and try again", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitions.isEmpty ? petitions.count : filteredPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // ternary operator instead short if-else statement
        let petition = filteredPetitions.isEmpty ? petitions[indexPath.row] : filteredPetitions[indexPath.row]

        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Load body on tap of the cell
        let vc = DetailViewController()
        vc.detailItem = filteredPetitions.isEmpty ? petitions[indexPath.row] : filteredPetitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }


}

