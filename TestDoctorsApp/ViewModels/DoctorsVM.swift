//
//  DoctorsVM.swift
//  TestDoctorsApp
//
//  Created by Игорь Крысин on 17.08.2024.
//

import Foundation

class DoctorsVM: ObservableObject {
    @Published var doctorsDataArray: [Users] = []
    @Published var arrayTabView: [PageItem] = PageItem.pages()
    
   
    private let networkManager = NetworkService()
    
    func getData() {
        networkManager.sendRequest { users in
            DispatchQueue.main.async {
                self.doctorsDataArray = users
                print("doctorsDataArray: ",  self.doctorsDataArray)
            }
            
        }
    }
    
}
