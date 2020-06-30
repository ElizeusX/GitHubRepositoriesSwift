//
//  CommitsPresenter.swift
//  Repositories
//
//  Created by Elizeus on 14/06/2020.
//  Copyright © 2020 Elizeus. All rights reserved.
//

import Foundation
import Alamofire

class CommitsPresenter {
    let repositoryName: String
    init(repositoryName: String, view: CommitsViewController) {
        self.repositoryName = repositoryName
        self.view = view
    }
    
    private weak var view: CommitsViewController?
    var commitData: [CommitData] = []
    var commitCount: Int{
        return commitData.count
    }
    
    func loadData() {
        let urlString = "\(detailsUrl)\(repositoryName)/commits"
        if let url = URL(string: urlString) {
            AF.request(url, headers: headers)
                .responseJSON { [weak self]response in
                    guard let jsonData = response.data else {
                        print("No data")
                        return
                    }
                    do {
                        let commits = try JSONDecoder().decode([CommitData].self, from: jsonData)
                        self?.commitData = Array(commits.prefix(10))
                        self?.view?.reloadData()
                        
                    } catch let error {
                        print(error.localizedDescription)
                        //TODO: Implement error handling
                    }
            }
        }
    }
    func cellItem(for row: Int) -> CommitData{
        return commitData[row]
    }
}
