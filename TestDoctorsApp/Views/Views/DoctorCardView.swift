//
//  DoctorCardView.swift
//  TestDoctorsApp
//
//  Created by Игорь Крысин on 18.08.2024.
//

import SwiftUI

struct DoctorCardView: View {
    var body: some View {
        VStack {
            HStack(spacing: 16) {
                Image(.car)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(.circle)
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(.horizontal, 16)
    }
}

#Preview {
    DoctorCardView()
}
