//
//  QiitaListRepository.swift
//  LayeredArchitectureApp01+Tests
//
//  Created by 濵田　悠樹 on 2022/08/04.
//

import Foundation

class QiitaListRepository {
    public func fetch() async throws -> [QiitaList]  {
        let qiitaList = try await APIRequest().fetch(component: QiitaListRequestComponent())
        print(qiitaList)
        return qiitaList
    }
}
