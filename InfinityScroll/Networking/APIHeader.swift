//
//  APIHeader.swift
//  InfinityScroll
//
//  Created by Олег on 13.07.2021.
//

import Foundation

final class APIHeader {
    var requestHeaders: [String: String] {
        get {
            var headers = self.getUnAuthHeaders()
            headers.merge(dict: self.getAuthHeaders())
            return headers
        }
    }
    
    /// Получить неавторизованные заголовки для запросов
    /// - Returns: [String: String]
    private func getUnAuthHeaders() -> [String: String] {
        var unAuthHeaders: [String: String] = [:]
        unAuthHeaders["Content-Type"] = "application/json"
        return unAuthHeaders
    }
    
    /// Получить авторизованные заголовки для запросов
    /// - Returns: [String: String]
    private func getAuthHeaders() -> [String: String] {
        let authHeaders: [String: String] = [:]
        return authHeaders
    }
}
