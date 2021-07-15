//
//  APIRequest.swift
//  InfinityScroll
//
//  Created by Олег on 04.07.2021.
//

import Foundation

final class APIRequest {
    /// Константы
    /// Таймаут
    private let timeout: TimeInterval = 30.0
    
    /// Заголовки для запросов
    private let headers: [String: String] = APIHeader().requestHeaders
    
    
    /// Сделать запрос
    /// - Parameters:
    ///   - type: тип запроса
    ///   - url: ссылка, по которой будет выполнен запрос
    ///   - params: параметры запроса
    ///   - success: обработка успешного ответа
    ///   - failure: обработка ошибки
    func makeRequest(type: APIRequestType, url: URL, params: [String: Any]?, success: @escaping (Data) -> Void, failure: @escaping (Error) -> Void) {
        /// Выполнение нужного запроса в зависимости от его типа
        switch type {
        case .GET:
            self.GETRequest(url: url, params: params, success: success, failure: failure)
        case .POST:
            self.POSTRequest(url: url, params: params, success: success, failure: failure)
        }
    }
    
    
    /// Get запрос
    /// - Parameters:
    ///   - url: URL
    ///   - params: [String: Any]?
    ///   - success: (Data) -> Void
    ///   - failure: (Error) -> Void
    private func GETRequest(url: URL, params: [String: Any]?, success: @escaping (Data) -> Void, failure: @escaping (Error) -> Void) {
        let configuration = URLSessionConfiguration.default
        /// Установка таймаута
        configuration.timeoutIntervalForRequest = self.timeout
        /// Создание сессии с конфигурацией
        let session = URLSession(configuration: configuration)
        /// Инициализация URLComponents
        var urlComponents = URLComponents(string: url.absoluteString)
        
        /// Добавление к ссылке query параметров
        if let params = params {
            params.forEach { (key, value) in
                /// Если query параметров нет, тогда инициализируем массив, для возможности сохранения параметров в него
                if urlComponents?.queryItems?.isEmpty ?? true {
                    urlComponents?.queryItems = []
                }
                /// Инициализация query параметра
                let queryItem = URLQueryItem(name: key, value: String(describing: value))
                urlComponents?.queryItems?.append(queryItem)
            }
        }
        /// Получаем готовую ссылку с query параметрами
        guard let url = urlComponents?.url else { return }
        
        /// Инициализация URLRequest
        var urlRequest = URLRequest(url: url)
        
        /// Добавление заголовков к запросу
        self.headers.forEach { (key, value) in
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
        
        /// Логирование
        print("🌎🌎🌎 GET Request: " + url.absoluteString)
        print("Headers: ")
        print(urlRequest.allHTTPHeaderFields ?? "В запросе нет заголовков")
        
        /// Выполнение запроса
        session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                /// Логирование
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    /// Логирование успешного ответа
                    print("✅✅✅ Response:")
                    print(json)
                    print("✅✅✅")
                    /// Передача полученых данных дальше
                    success(data)
                } catch {
                    /// Логирование ошибки
                    print("🛑🛑🛑 Error:" + error.localizedDescription)
                    /// Передача полученой ошибки дальше
                    failure(error)
                }
            } else if let error = error {
                /// Логирование ошибки
                print("🛑🛑🛑 Error:" + error.localizedDescription)
                /// Передача полученой ошибки дальше
                failure(error)
            }
        }.resume()
    }
    
    
    /// Post запрос
    /// - Parameters:
    ///   - url: URL
    ///   - params: [String: Any]?
    ///   - success: (Data) -> Void
    ///   - failure: (Error) -> Void
    private func POSTRequest(url: URL, params: [String: Any]?, success: @escaping (Data) -> Void, failure: @escaping (Error) -> Void) {
        /// Инициализация сессии
        let session = URLSession.shared
        /// Инициализация URLRequest
        var urlRequest = URLRequest(url: url)
        /// Установка таймаута
        urlRequest.timeoutInterval = self.timeout
        /// Установка типа запроса
        urlRequest.httpMethod = APIRequestType.POST.rawValue
        
        /// Создание тела post запроса
        if let params = params, let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) {
            urlRequest.httpBody = httpBody
        }
        
        /// Установка заголовков запроса
        self.headers.forEach { (key, value) in
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
        
        /// Логирование
        print("🌎🌎🌎 POST Request: " + (urlRequest.url?.absoluteString ?? ""))
        print("Headers: ")
        print(urlRequest.allHTTPHeaderFields ?? "В запросе нет заголовков")
        
        /// Выполнение запроса
        session.dataTask(with: urlRequest) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    /// Логирование успешного ответа
                    print("✅✅✅ Response:")
                    print(json)
                    print("✅✅✅")
                    /// Передача полученых данных дальше
                    success(data)
                } catch {
                    /// Логирование ошибки
                    print("🛑🛑🛑 Error:" + error.localizedDescription)
                    /// Передача полученой ошибки дальше
                    failure(error)
                }
            } else if let error = error {
                /// Логирование ошибки
                print("🛑🛑🛑 Error:" + error.localizedDescription)
                /// Передача полученой ошибки дальше
                failure(error)
            }
        }.resume()
    }
}
