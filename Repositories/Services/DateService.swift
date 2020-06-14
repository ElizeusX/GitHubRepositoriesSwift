//
//  DateService.swift
//  Repositories
//
//  Created by Elizeus on 14/06/2020.
//  Copyright © 2020 Elizeus. All rights reserved.
//

import Foundation

class DateService{
    func convert(from date: String, format: String = "yyyy-MM-dd'T'HH:mm:ssZ") -> Date? {
        let formater = DateFormatter()
        formater.dateFormat = format
        return formater.date(from: date)
       
    }
    func convert(from date: Date, format: String = "yyyy-MM-dd HH:mm") -> String? {
        let formater = DateFormatter()
        formater.dateFormat = format
        return formater.string(from: date)
       
    }
}
