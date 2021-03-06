//
//  ViewController.swift
//  Repositories
//
//  Created by Elizeus on 05/06/2020.
//  Copyright © 2020 Elizeus. All rights reserved.
//

import UIKit
import Alamofire

class RepositoryViewController: UIViewController {
    
    @IBOutlet private var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    var presenter: RepositoryPresenter!
    
    //var repositoryData = [RepositoryData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            presenter.loadData()
    }
    
    func reloadData(){
        tableView.reloadData()
    }
    
//    func loadData() {
//        if let url = URL(string: baseUrl) {
//            AF.request(url, headers: headers)
//                .responseJSON { response in
//                    guard let results = response.data else {
//                        return
//                    }
//                    do {
//                        self.repositoryData = try JSONDecoder().decode([RepositoryData].self, from: results)
//                        self.tableView.reloadData()
//                    } catch let error {
//                        print(error.localizedDescription)
//                        //TODO: Implement error handling
//                    }
//            }
//        }
//    }
    
    
}


//MARK: - UITableViewDataSource, UITableViewDelegate

extension RepositoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.repositoryCount
        //return repositoryData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let repositoryRow = presenter.cellItem(for: indexPath.row)
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = repositoryRow.name.capitalized
        //cell.textLabel?.text = repositoryData[indexPath.row].name.capitalized
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentBranchesView(repositoryData: presenter.cellItem(for: indexPath.row))
//        presentBranchesView(repositoryData: repositoryData[indexPath.row])
    }
    
    func presentBranchesView (repositoryData: RepositoryData){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let branchesViewController = storyboard.instantiateViewController(withIdentifier: "BranchesViewController") as? BranchesViewController else {
            return
        }
        
        let presenter = BranchesPresenter(
            repositoryName: repositoryData.name,
            view: branchesViewController
            
        )
        branchesViewController.presenter = presenter
        navigationController?.show(branchesViewController, sender: nil)
    }
}
