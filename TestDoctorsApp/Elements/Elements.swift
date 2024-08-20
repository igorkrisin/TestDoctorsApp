//
//  Elements.swift
//  TestDoctorsApp
//
//  Created by Игорь Крысин on 16.08.2024.
//

import Foundation
import SwiftUI

enum SortOption {
    case price
    case expirience
    case rating
}

class Elements {
    static func makeBtn (text: String, action:  ()) -> some View {
        Button {
            action
        } label: {
            Text(text)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.gray)
                .frame(maxWidth: .infinity, maxHeight: 32)
                .padding(.horizontal, 10)
                .background(.white)
                .clipped()
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.myLightGray, lineWidth: 1)
                }
        }
    }
    
    static func makeAppointmentBtn (isHaveAppointment: Bool, action:  ()) -> some View {
        Button {
            isHaveAppointment ? action : ()
        } label: {
            isHaveAppointment ? Text("Записаться") : Text("Нет свободного расписания")
        }
        .frame(maxWidth: .infinity)
        .frame(height: 47)
        .background(isHaveAppointment ? .myPink : .myLightGray)
        .foregroundColor( isHaveAppointment ? .white : .black)
        .font(.system(size: 16, weight: .semibold))
        .clipShape(.rect(cornerRadius: 8))
        .padding(.bottom, 16)
    }
}
struct CustomSortBtn: View {
    
    var text: String
    var backgroundColor: Color
    var textColor: Color
    var cornerRadius: CGFloat
    var sortOption: SortOption
    var selectOption: SortOption?
    var isArrowUp: Bool
    var action: () -> Void
    
    var body: some View {
        
        Button(action: action){
            HStack{
                Text(text)
                    .font(.system(size: 14, weight: .regular))
                    
                    
                    .padding(.horizontal, 3)
                    
                    .clipped()
                    
                
                if selectOption == sortOption {
                    Image(systemName: isArrowUp ? "arrow.down" : "arrow.up")
                        .resizable()
                        .frame(maxWidth: 10, maxHeight: 10)
                    
                }
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: 32)
        .foregroundStyle(selectOption == sortOption ? .white : .gray)
        .padding(.horizontal, 10)
        .background(selectOption == sortOption ? .myPink : .white)
        .clipShape(.rect(cornerRadius: 5))
        
        
    }
}
