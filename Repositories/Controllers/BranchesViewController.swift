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
    
    @IBOutlet weak var branchTableView: UITableView!{
        didSet{
            branchTableView.delegate = self
            branchTableView.dataSource = self
        }
    }
    var branchData = [BranchData]()
    var repositoryData: ReposData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }

    
    func loadData() {
        guard let repositoryName = repositoryData?.name else {
            return
        }
        let urlString = "\(detailsUrl)\(repositoryName)/branches"
        if let url = URL(string: urlString) {
            AF.request(url, headers: headers)
                .responseJSON { response in
                    let results = response.data
                    do {
                        self.branchData = try JSONDecoder().decode([BranchData].self, from: results!)
                        self.branchTableView.reloadData()
                    } catch let error {
                        print(error.localizedDescription)
                        //TODO: Implement error handling
                    }
            }
        }
    }
    
    //MARK: - Send repositories name in CommitPresenter for CommitsViewController
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard  let commitsVC : CommitsViewController = segue.destination as? CommitsViewController
            else {
                return
        }
        guard let repositoryName = repositoryData?.name else {
            return
        }
        let url = "\(detailsUrl)\(repositoryName)/commits"
        commitsVC.presenter = CommitPresenter(url: url, view: commitsVC)
    }
}


//MARK: - UITableViewDataSource, UITableViewDelegate
extension BranchesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return branchData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BranchCell") as! BranchCell
        cell.branchLabel.text = branchData[indexPath.row].name.capitalized
        return cell
    }
}
