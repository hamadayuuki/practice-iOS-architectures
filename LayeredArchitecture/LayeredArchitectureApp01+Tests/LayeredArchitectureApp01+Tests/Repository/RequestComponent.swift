//
//  RequestComponent.swift
//  LayeredArchitectureApp01+Tests
//
//  Created by 濵田　悠樹 on 2022/08/05.
//

import Foundation

// 様々な ~~RequestComponent 使えるようにする
// ~~RequestComponent の要素を APIRequest() で使えるようにするため (例: component.query)
public protocol RequestComponent {
    associatedtype type: Codable
    var query: String { get }
}
