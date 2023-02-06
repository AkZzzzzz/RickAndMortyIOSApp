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
    
    ///Приватизированый конструктор
    private init() {}
    
    ///Отправление вызова API
    public func execute<T: Codable>(
        _ request: RSRequest,
        expecting type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {

    }
}
