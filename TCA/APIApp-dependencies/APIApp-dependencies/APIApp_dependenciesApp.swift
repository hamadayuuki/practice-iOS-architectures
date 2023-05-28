//
//  APIApp_dependenciesApp.swift
//  APIApp-dependencies
//
//  Created by 濵田　悠樹 on 2023/05/19.
//

import ComposableArchitecture
import SwiftUI

@main
struct APIApp_dependenciesApp: App {
    var body: some Scene {
        WindowGroup {
            APIAppView(store: Store(initialState: APIAppStore.State()) {
                APIAppStore()
            })
        }
    }
}
