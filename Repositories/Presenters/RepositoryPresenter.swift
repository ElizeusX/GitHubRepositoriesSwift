//
//  RepositoryPresenter.swift
//  Repositories
//
//  Created by Elizeus on 17/06/2020.
//  Copyright © 2020 Elizeus. All rights reserved.
//

import Foundation
import Alamofire

class RepositoryPresenter {
    init(view: RepositoryViewController) {
        self.view = view
    }
    
    private weak var view: RepositoryViewController?
    var repositoryData: [RepositoryData] = []
    var repositoryCount: Int {
        return repositoryData.count
    }
    
    func loadData() {
        if let url = URL(string: baseUrl) {
            AF.request(url, headers: headers)
                .responseJSON { response in
                    guard let jsonData = response.data else {
                        return
                    }
                    do {
                        self.repositoryData = try JSONDecoder().decode([RepositoryData].self, from: jsonData)
                        self.view?.reloadData()
                    } catch let error {
                        print(error.localizedDescription)
                        //TODO: Implement error handling
                    }
            }
        }
    }
    func cellItem(for row: Int) -> RepositoryData{
             return repositoryData[row]
         }
}
