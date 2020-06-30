//
//  BranchesViewController.swift
//  Repositories
//
//  Created by Elizeus on 12/06/2020.
//  Copyright © 2020 Elizeus. All rights reserved.
//

import UIKit
import Alamofire

class BranchesViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    var presenter: BranchesPresenter!
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.loadData()
    }
    
    func reloadData(){
           tableView.reloadData()
       }
    
    //MARK: - Send repositories name in CommitPresenter for CommitsViewController
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showCommits", let commitsVC : CommitsViewController = segue.destination as? CommitsViewController
            else {
                return
        }
       
        let repositoryName = presenter.repositoryName
        commitsVC.presenter = CommitsPresenter(repositoryName: repositoryName, view: commitsVC)
    }
    
}


//MARK: - UITableViewDataSource, UITableViewDelegate
extension BranchesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.branchCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let branchRow = presenter.cellItem(for: indexPath.row )
        let cell = tableView.dequeueReusableCell(withIdentifier: "BranchCell") as! BranchCell
        //cell.branchLabel.text = branchData[indexPath.row].name.capitalized
        cell.branchLabel.text = branchRow.name.capitalized
        return cell
    }
}
