//
//  QiitaListView.swift
//  LayeredArchitectureApp01+Tests
//
//  Created by 濵田　悠樹 on 2022/08/04.
//

import SwiftUI

struct QiitaListView: View {
    @StateObject private var qiitaListFeature = QiitaListFeature(qiitaListRepository: QiitaListRepository())   // TODO: AppDependency で可変に, ViewはRepositoryの存在を知らないようにしたい
    
    var body: some View {
            List {
                ForEach(qiitaListFeature.qiitaList) { detail in
                    Text(detail.title)
                }
            }
            .onAppear {
                Task {
                    try await qiitaListFeature.fetch()
                    print(qiitaListFeature.qiitaList)
                }
            }
    }
}

struct QiitaListView_Previews: PreviewProvider {
    static var previews: some View {
        QiitaListView()
    }
}
