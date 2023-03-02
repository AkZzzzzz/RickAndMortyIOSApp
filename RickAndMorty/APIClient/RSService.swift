//
//  RSService.swift
//  RickAndMorty
//
//  Created by Артём Козловский on 06.02.2023.
//

import Foundation

///Основной объект для получения данных
final class RSService {
    ///Общий экземплр синглтона
    static let share = RSService()
    
    private let cacheManager = RSAPICacheManager()
    
    ///Приватизированый конструктор
    private init() {}
    
    enum RSServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
    }
    
    ///Отправление вызова API
    public func execute<T: Codable>(
        _ request: RSRequest,
        expecting type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        if let cachedData = cacheManager.cachedResponse(for: request.endpoint, url: request.url) {
            print("Using cache API response")

            do {
                let result = try JSONDecoder().decode(type.self, from: cachedData)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
            return
        }
        
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(RSServiceError.failedToCreateRequest))
            return
        }
      
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? RSServiceError.failedToGetData))
                return
            }
            //DECODE
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                self?.cacheManager.setCache(for: request.endpoint, url: request.url, data: data)
                completion(.success(result))

            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    private func request(from rsRequest: RSRequest) -> URLRequest? {
        guard let url = rsRequest.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = rsRequest.httpMethod
        
        return request
    }
}
