//
//  Service.swift
//  CompanyInfo
//
//  Created by Bekzod Rakhmatov on 17/02/2019.
//  Copyright © 2019 BekzodRakhmatov. All rights reserved.
//

import Foundation

struct Service {
    
    static let shared = Service()
    
    let urlString = "https://api.letsbuildthatapp.com/intermediate_training/companies"
    
    func donwloadCompaniesFromServer() {
        
        print("Attempting to download companies")
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            print("Finished downloading")
            
            if let error = error {
                print("Failed to download companies: \(error)")
                return
            }
            
            guard let data = data else { return }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let jsonCompanies = try jsonDecoder.decode([JSONCompany].self, from: data)
                jsonCompanies.forEach({ (jsonCompany) in
                    print(jsonCompany.name)
                    jsonCompany.employees?.forEach({ (jsonEmployee) in
                        print(jsonEmployee.name)
                    })
                })
            } catch let error {
                print("Failed to decode SJONCompany: \(error)")
            }
            
            
            
        }.resume()
    }
}

struct JSONCompany: Decodable {
    
    let name:    String
    let founded: String
    var employees: [JSONEmployee]?
}

struct JSONEmployee: Decodable {
    
    let name: String
    let type: String
    let birthday: String
}
