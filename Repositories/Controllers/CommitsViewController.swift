//
//  CommitsViewController.swift
//  Repositories
//
//  Created by Elizeus on 12/06/2020.
//  Copyright © 2020 Elizeus. All rights reserved.
//

import UIKit
import Alamofire

class CommitsViewController: UIViewController {
    
    @IBOutlet weak var commitTableView: UITableView!{
        didSet{
            commitTableView.delegate = self
            commitTableView.dataSource = self
        }
    }
    
    var presenter: CommitPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
    
        presenter.loadData()
    }
    
    @IBAction func branchesButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    func reloadData(){
        commitTableView.reloadData()
    }
}

//MARK: -   UITableViewDataSource,  UITableViewDelegate
extension CommitsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.commitCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let commitRow = presenter.cellItem(for: indexPath.row )
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommitCell") as! CommitCell
        cell.setLabel(commitData: commitRow)
        return cell
    }
}
