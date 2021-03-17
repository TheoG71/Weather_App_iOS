//
//  WeatherService.swift
//  Weather-app-swiftUI
//
//  Created by Lilian on 08/03/2021.
//

import Foundation

protocol WeatherServiceProtocol {
    func getFiveDaysForecast(city: String, completion: @escaping (Result<WeatherModel, NetworkingError>) -> Void)
}

final class WeatherService {
    static let shared: WeatherServiceProtocol = WeatherService()
    private let urlSession: URLSession
    private let baseURLString = "https://api.openweathermap.org/data/2.5/forecast?"
    private let dateJSONDecoder: DateJSONDecoder
    private let appId = "0670ef976e4023eee0da269c55c4680e"

    init(
        urlSession: URLSession = .shared,
        dateJSONDecoder: DateJSONDecoder = .init()
    ) {
        self.urlSession = urlSession
        self.dateJSONDecoder = dateJSONDecoder
    }
}

extension WeatherService: WeatherServiceProtocol {
    func getFiveDaysForecast(
        city: String,
        completion: @escaping (Result<WeatherModel, NetworkingError>) -> Void
    ) {
        guard let listingURL = URL(string: "\(baseURLString)q=\(city)&appid=\(appId)") else {
            completion(.failure(.invalidUrl))
            return
        }

        urlSession.dataTask(with: listingURL) {  [weak self] data, _, error in
            guard error == nil, let self = self else {
                completion(.failure(.internetConnectivity))
                return
            }

            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            do {
                let weather = try self.dateJSONDecoder.decode(WeatherModel.self, from: data)
                completion(.success(weather))
            } catch {
                completion(.failure(.decode))
            }
        }.resume()
    }
}
