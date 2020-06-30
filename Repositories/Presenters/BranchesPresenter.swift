//
//  BranchesPresenter.swift
//  Repositories
//
//  Created by Elizeus on 15/06/2020.
//  Copyright © 2020 Elizeus. All rights reserved.
//

import Foundation
import Alamofire

class BranchesPresenter {
    init(repositoryName: String, view: BranchesViewController) {
        self.repositoryName = repositoryName
        self.view = view
    }
    
    
    private weak var view: BranchesViewController?
    private var branchData: [BranchData] = []
    let repositoryName: String
    var branchCount: Int {
        return branchData.count
    }
    
    
    func loadData() {
        let urlString = "\(detailsUrl)\(repositoryName)/branches"
        if let url = URL(string: urlString) {
            AF.request(url, headers: headers)
                .responseJSON { response in
                    guard let jsonData = response.data else {
                        return
                    }
                    do {
                        self.branchData = try JSONDecoder().decode([BranchData].self, from: jsonData)
                        self.view?.reloadData()
                    } catch let error {
                        print(error.localizedDescription)
                        //TODO: Implement error handling
                    }
            }
        }
    }
    func cellItem(for row: Int) -> BranchData{
        return branchData[row]
    }
    
}
