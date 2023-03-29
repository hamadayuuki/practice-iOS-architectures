//
//  ContentView.swift
//  swift-dependencies
//
//  Created by 濵田　悠樹 on 2023/03/24.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    @Dependency(\.factClient) var factClient
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
                .onAppear {
                    Task {
                        print(try await factClient.fetch(3))
                    }
                }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
