//
//  TabViewItem.swift
//  TestDoctorsApp
//
//  Created by Игорь Крысин on 18.08.2024.
//

import SwiftUI

struct TabViewItem: View {
    
    @Binding var selectionPage: String
    var page: PageItem
    
    var body: some View {
        VStack {
            Button {
                withAnimation(.bouncy) {
                    selectionPage = page.pageTag
                }
                
            } label: {
                Image(systemName: page.pageTag)
                    .resizable()
                    .frame(width: 23, height: 23)
                    .foregroundStyle(selectionPage == page.pageTag ? .myPink : .gray)
            }
            Text(page.pageName)
                .foregroundStyle(selectionPage == page.pageTag ? .myPink : .gray)
                .font(.system(size: 12))
        }
    }
}

struct PageItem: Identifiable {
    let id = UUID()
    let pageName: String
    let pageTag: String
    
    static func pages() -> [PageItem] {
        [
            PageItem(pageName: "Main", pageTag: "house.fill"),
            PageItem(pageName: "Appointmetn", pageTag: "calendar"),
            PageItem(pageName: "Message", pageTag: "message.fill"),
            PageItem(pageName: "Profile", pageTag: "person.fill"),
        ]
    }
}


