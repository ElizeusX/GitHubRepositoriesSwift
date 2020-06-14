//
//  CommitsPresenter.swift
//  Repositories
//
//  Created by Elizeus on 14/06/2020.
//  Copyright © 2020 Elizeus. All rights reserved.
//

import Foundation
import Alamofire

class CommitPresenter {
    let commitURL: String
    init(url: String, view: CommitsViewController) {
        commitURL = url
        self.view = view
        
    }
    private weak var view: CommitsViewController?
    var commits: [CommitItem] = []
    var commitCount: Int{
        return commits.count
    }
    
    func loadData() {
         if let url = URL(string: commitURL) {
             AF.request(url, headers: headers)
             .responseJSON { [weak self]response in
                 guard let jsonData = response.data else {
                     print("No data")
                     return
                 }
                 do {
                     let commits = try JSONDecoder().decode([CommitItem].self, from: jsonData)
                     self?.commits = Array(commits.prefix(10))
                     self?.view?.reloadData()
            
                 } catch let error {
                     print(error.localizedDescription)
                     //TODO: Implement error handling
                 }
             }
         }
     }
    func cellItem(for row: Int) -> CommitItem{
        return commits[row]
    }
}
