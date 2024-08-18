//
//  DoctorModels.swift
//  TestDoctorsApp
//
//  Created by Игорь Крысин on 16.08.2024.
//

import Foundation

struct DoctorModels: Decodable {
    let record: Record
}

struct Record: Decodable {
    let data: DoctorData
}

struct DoctorData: Decodable {
    let users: [Users]
}

struct Users: Identifiable, Decodable {
    let id: String
    let first_name: String?
    let patronymic: String?
    let last_name: String?
    let ratings: [Rating?]
    let rank: Int
    var is_favorite: Bool?
    let avatar: String?
    let scientific_degree_label: String?//ученая степень
    let work_expirience: [WorkExp?]
    let specialization: [Specialization?]
    let ratings_rating: Float?
    let free_reception_time: [ReceptionTime?]
    let hospital_price: Int?
    let home_price: Int?
    let video_chat_price: Int?
    let text_chat_price: Int?
    
}

struct Rating: Decodable {
   
}

struct WorkExp: Decodable {
    let id: Int?
    let start_date: Int?
    let end_date: Int?
}

struct Specialization: Decodable {
    let name: String?
}

struct ReceptionTime: Decodable {
    
}

