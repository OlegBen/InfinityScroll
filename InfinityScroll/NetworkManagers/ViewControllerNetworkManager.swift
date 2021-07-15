//
//  ViewControllerNetworkManager.swift
//  InfinityScroll
//
//  Created by Олег on 04.07.2021.
//

import Foundation

final class ViewControllerNetworkManager {
    private let baseURL = APIUrl.baseURL
    
    /// Получение списка модераторов
    /// - Parameters:
    ///   - page: номер страницы (пагинация)
    ///   - success: обработка успешного ответа
    ///   - failure: обработка ошибки
    func getModeratorsList(page: Int, success: @escaping (ModeratorsResponse) -> Void, failure: @escaping (Error) -> Void) {
        /// Подготовка ссылки, для выполнения запроса
        let baseURL = APIUrl.baseURL + "/" + APIVersion.version_2_2.rawValue + APIUrl.moderatorsPath
        /// Получившаяся ссылка должна бать валидной
        guard let url = URL(string: baseURL) else { return }
        /// Подготовка параметров, для запроса
        let params = [
            "site": "stackoverflow",
            "page": String(page),
            "filter": "!-*jbN0CeyJHb",
            "sort": "reputation",
            "order": "desc"
        ]
        /// Выполнение запроса
        APIRequest().makeRequest(type: .GET, url: url, params: params) { (data) in
            do {
                let moderators = try JSONDecoder().decode(ModeratorsResponse.self, from: data)
                success(moderators)
            } catch {
                failure(error)
            }
        } failure: { (error) in
            failure(error)
        }

    }
}
