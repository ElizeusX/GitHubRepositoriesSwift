//
//  ViewController.swift
//  Repositories
//
//  Created by Elizeus on 05/06/2020.
//  Copyright © 2020 Elizeus. All rights reserved.
//

import UIKit
import Alamofire

class ReposViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    var reposData = [ReposData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    func loadData() {
        let url = URL(string: baseUrl)
        AF.request(url!, headers: headers)
            .responseJSON { response in
                let results = response.data
                do {
                    self.reposData = try JSONDecoder().decode([ReposData].self, from: results!)
                    self.tableView.reloadData()
                } catch let error {
                    print(error.localizedDescription)
                    //TODO: Implement error handling
                }
        }
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate

extension ReposViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reposData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = reposData[indexPath.row].name.capitalized
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let branchesViewController = storyboard.instantiateViewController(withIdentifier: "BranchesViewController") as? BranchesViewController else {
            return
        }
        branchesViewController.repositoryData = reposData[indexPath.row]
        self.show(branchesViewController, sender: self)
    }
}
