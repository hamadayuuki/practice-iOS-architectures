//
//  QiitaListFeature.swift
//  LayeredArchitectureApp01+Tests
//
//  Created by 濵田　悠樹 on 2022/08/05.
//

import Foundation

//                      ↓ 宣言的にデータ(qiitaList)を渡すために
class QiitaListFeature: ObservableObject {
    let qiitaListRepository: QiitaListRepository
    @Published public var qiitaList: [QiitaList] = [QiitaList]()
    
    init(qiitaListRepository: QiitaListRepository) {
        self.qiitaListRepository = qiitaListRepository
    }
    
    func fetch() async throws {
        qiitaList = try await qiitaListRepository.fetch()
        print(qiitaList)
    }
}
