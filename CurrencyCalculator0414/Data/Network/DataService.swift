//
//  DataService.swift
//  CurrencyCalculator0414
//
//  Created by tlswo on 4/14/25.
//

import Foundation

class DataService: DataServiceProtocol {
    enum DataServiceError: Error {
        case invalidResponse
        case invalidData
    }
    
    func loadCurrencies(completion: @escaping (Result<[CurrencyItem],Error>) -> Void) {
        let urlString = "https://open.er-api.com/v6/latest/USD"
        
        guard let url = URL(string: urlString) else {
            print("URL 생성 실패")
            completion(.failure(DataServiceError.invalidData))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("에러 발생: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("응답 오류: \(response.debugDescription)")
                completion(.failure(DataServiceError.invalidResponse))
                return
            }
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(CurrencyResponse.self, from: data)
                    let items = decodedData.rates.map { CurrencyItem(
                        currencyCode: $0.key,
                        rate: $0.value,
                        country: CurrencyMapper.country(for: $0.key),
                        isDown: .same,
                        isFavorite: false
                    )}
                    completion(.success(items))
                } catch {
                    print("JSON 파싱 에러: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}

