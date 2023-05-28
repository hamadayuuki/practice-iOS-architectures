//
//  APIAppView.swift
//  APIApp-dependencies
//
//  Created by 濵田　悠樹 on 2023/05/19.
//

import ComposableArchitecture
import SwiftUI

struct APIAppView: View {
    //@StateObject private var apiAppViewModel = APIAppViewModel()
    let store: StoreOf<APIAppStore>
    @State private var text = ""

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationView {
                VStack {
                    Button(action: {
                        viewStore.send(.tappedClearButton)
                    }, label: {
                        Text("Clear")
                    })
                    
                    List {
                        ForEach(0..<viewStore.repos.count, id: \.self) { index in
                            Text(viewStore.repos[index].full_name)
                        }
                    }
                }
            }
            .searchable(text: $text, placement: .navigationBarDrawer(displayMode: .always), prompt: "検索値")
            .onSubmit(of: .search) {
                viewStore.send(.tappedSearchButton(text))
            }
        }
    }
}

struct APIAppView_Previews: PreviewProvider {
    static var previews: some View {
        APIAppView(store: Store(initialState: APIAppStore.State()) {
            APIAppStore()
        })
    }
}
