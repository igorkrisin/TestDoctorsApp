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
    
    func getJsonData() {
        if let dataArray =  networkManager.loadUsersFromJSON()?.record.data.users{
            self.doctorsDataArray = dataArray
        }
    }
    
    func getData() {
        networkManager.sendRequest { users in
            DispatchQueue.main.async {
                self.doctorsDataArray = users
                print("doctorsDataArray: ",  self.doctorsDataArray)
            }
            
        }
    }
    
     func dateExpirience(workExp: [WorkExp?]) -> Int {
        var summ = 0
        for date in workExp {
            
            guard let date = date, let startDate = date.start_date, let endDate = date.end_date else { return 0 }
            summ += endDate - startDate
        }
        return summ / 31556925
    }
    
    func giveSpecialization(specializationArr: [Specialization?]) -> String {
        for specialization in specializationArr {
            guard let spepecialization = specialization?.name else { return ""}
            return spepecialization
        }
        return ""
    }
    
    func lessPrise(users: Users) -> Int {
       
        guard let videoPrice = users.video_chat_price, let chatPrice = users.text_chat_price, let hospitalPrise = users.home_price else { return 0}
        let priceArray: [Int] = [chatPrice, hospitalPrise]
        var lessPrice = videoPrice
        
        for price in priceArray {
            if price < lessPrice {
                lessPrice = price
            }
        }
        
        return lessPrice
    }
    
    func toggleSingLessMore(doctors: DoctorsVM, turn: Bool) {
        if turn {
            return doctors.doctorsDataArray.sort {
                $0.ratings_rating ?? 0 > $1.ratings_rating ?? 0
            }
        } else {
            return doctors.doctorsDataArray.sort {
                $0.ratings_rating ?? 0 < $1.ratings_rating ?? 0
            }
        }
    }
    
    
    
    func toggleSort<T: Comparable>(in array: inout [Users], by keyPath: KeyPath<Users, T?>, ascending: Bool) {
        array.sort {
            guard let firstValue = $0[keyPath: keyPath], let secondValue = $1[keyPath: keyPath] else {
                return false
            }
            return ascending ? firstValue < secondValue : firstValue > secondValue
        }
    }
    
}
