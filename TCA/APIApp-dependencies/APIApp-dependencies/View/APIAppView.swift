//
//  APIAppView.swift
//  APIApp-dependencies
//
//  Created by 濵田　悠樹 on 2023/05/19.
//

import SwiftUI

struct APIAppView: View {
    @StateObject var apiAppViewModel = APIAppViewModel()
    @State var text = ""

    var body: some View {
        NavigationView {
            List {
                ForEach(0..<apiAppViewModel.repos.count, id: \.self) { index in
                    Text(apiAppViewModel.repos[index])
                }
            }
        }
        .searchable(text: $text, placement: .navigationBarDrawer(displayMode: .always), prompt: "検索値")
        .onSubmit(of: .search) {
            
        }
        .onAppear {
            Task {
                await apiAppViewModel.fetch()
            }
        }
    }
}

struct APIAppView_Previews: PreviewProvider {
    static var previews: some View {
        APIAppView()
    }
}
