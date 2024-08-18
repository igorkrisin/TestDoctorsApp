//
//  NetworkService.swift
//  TestDoctorsApp
//
//  Created by Игорь Крысин on 17.08.2024.
//

import Foundation

//
//  NetworkService.swift
//  HW 5 Parse Jsone
//
//  Created by Игорь Крысин on 01.08.2024.
//


protocol NetworkProtocol: AnyObject {
    var url: URL? { get set }
    var request: URLRequest? { get set }
    func sendRequest(completion: @escaping ([Users]) -> ())
}


class NetworkService: NetworkProtocol {
  
    
    //1 URL
    var url: URL?
    
    //https://
    //api.unsplash.com/
    //search/photos
    
    //?page=1
    //&query=ios
    //&client_id=U4v9d_JJ3QKhGYSKidxa0Vt9jgC0oN_8SuiwIOeF0Q0
    
    
    
    //2 create req
    var request: URLRequest?
    
    
    
    func sendRequest(completion: @escaping ([Users]) -> ()) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.jsonbin.io"
        urlComponents.path = "/v3/b/655b754e0574da7622c94aa4"
        
//        urlComponents.queryItems = [
//            URLQueryItem(name: "page", value: page),
//            URLQueryItem(name: "query", value: query),
//            URLQueryItem(name: "client_id", value: "U4v9d_JJ3QKhGYSKidxa0Vt9jgC0oN_8SuiwIOeF0Q0"),
//        ]
        
        self.url = urlComponents.url
        //print(url)
        
        if let url = url {
            request = URLRequest(url: url)
            
            
            URLSession.shared.dataTask(with: request!) { data , responcse, err in
                guard err == nil else {
                    print(err!.localizedDescription)
                    return
                }
                
                if let jsonData = data {
                    do {
                        let doctorsDataResponse = try JSONDecoder().decode(DoctorModels.self, from: jsonData)
                        
                        completion(doctorsDataResponse.record.data.users)
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                }
                
                
            }.resume()
        }
    }
    
    //3 ren request
    
}
