//
//  APIAppView.swift
//  APIApp-dependencies
//
//  Created by 濵田　悠樹 on 2023/05/19.
//

import SwiftUI

struct APIAppView: View {
    private var repos = ["Apple", "Swift", "Concurrency"]
    @State var text = ""

    var body: some View {
        NavigationView {
            List {
                ForEach(0..<repos.count) { index in
                    Text(repos[index])
                }
            }
        }
        .searchable(text: $text, placement: .navigationBarDrawer(displayMode: .always), prompt: "検索値")
        .onSubmit(of: .search) {
            
        }
    }
}

struct APIAppView_Previews: PreviewProvider {
    static var previews: some View {
        APIAppView()
    }
}
