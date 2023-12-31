//
//  ServiceProvider.swift
//  Sporty
//
//  Created by Smaro Goulianou on 26/8/23.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}


class ServiceProvider {
    static let sharedInstance = ServiceProvider()


    private init() {}


    /// Loads the data from the specified endpoint.
    ///
    /// - Parameters:
    ///   - service: The API service we want to load the data from.
    ///   - decodeType: The decode model of the success response.
    ///   - completion: The job to be done when the API call completes.
    func load<U>(service: Service, decodeType: U.Type, completion: @escaping(Result<U>) -> Void) where U: Decodable {
        call(service.urlRequest, completion: { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(decodeType, from: data)
                    completion(.success(response))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    
    /// Makes the API call to the specified endpoint.
    ///
    /// - Parameters:
    ///   - request: The request to make.
    ///   - completion: The job to be done when the response is received.
    private func call(_ request: URLRequest, completion: @escaping (Result<Data>) -> Void) {
        let urlSession = URLSession.shared

        urlSession.dataTask(with: request) { (data, _, error) in
            if let responseError = error {
                DispatchQueue.main.async {
                    completion(.failure(responseError))
                }
            } else if let responseData = data {
                DispatchQueue.main.async {
                    completion(.success(responseData))
                }
            }
        }.resume()
    }
}
