//
//  Elements.swift
//  TestDoctorsApp
//
//  Created by Игорь Крысин on 16.08.2024.
//

import Foundation
import SwiftUI

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
