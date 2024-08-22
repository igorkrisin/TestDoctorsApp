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
    
    
   
    let networkManager = NetworkService()
    
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
    
     func dateExpirience(users: Users) -> Int {
        var summ = 0
         for date in users.work_expirience {
            
            guard let date = date, let startDate = date.start_date, let endDate = date.end_date else { return 0 }
            summ += endDate - startDate
        }
        return summ / 31556925
    }
    
    func giveSpecialization(user: Users) -> String {
        if user.specialization.isEmpty {
            return "Не указана"
        }
        
        var summSpecialization: String = ""
        for specialization in user.specialization {
            
            guard let specialization = specialization else { return ""}
            summSpecialization += " \(specialization.name ?? "")"
        }
        
        return summSpecialization
    }
    
    func lessPrise(users: Users) -> Int {
       
        guard let videoPrice = users.video_chat_price, let chatPrice = users.text_chat_price, let hospitalPrise = users.home_price else { return 0}
        
        return min(videoPrice, chatPrice, hospitalPrise)
    }
    
    func sortByRating(doctors: DoctorsVM, turn: Bool) {
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
    
    func sortByExpirience(doctors: DoctorsVM, turn: Bool) {
        if turn {

            return doctors.doctorsDataArray.sort {
                dateExpirience(users:  $0) >  dateExpirience(users:  $1)
                
            }
        } else {
  
            return doctors.doctorsDataArray.sort {
                dateExpirience(users:  $0) <  dateExpirience(users:  $1)
                
            }
            
        }
    }
    
    func sortByprice(doctors: DoctorsVM, turn: Bool) {
        if turn {
            return doctors.doctorsDataArray.sort {
                lessPrise(users:  $0) >  lessPrise(users:  $1)
                
            }
        } else {
            return doctors.doctorsDataArray.sort {
                lessPrise(users:  $0) <  lessPrise(users:  $1)
                
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
    
    func giveEducationTypeLabel(users: Users) -> String {
        
        var summEducation: String = ""
        if users.higher_education.isEmpty {
            return "Учебное заведение не указано"
        }
        for education in users.higher_education {
            if let higherEducation = education?.university {
                summEducation += " \(higherEducation)"
            }
            
        }
        
        
        return summEducation
    }
    
}
