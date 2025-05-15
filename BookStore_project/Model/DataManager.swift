//
//  DataManager.swift
//  BookStore_project
//
//  Created by Sophie on 5/13/25.
//

import Foundation

struct BookApi {
    
    let myApi = "88468a6bac6216fe1153fe1025268714"
    
    func fetchData(completion: @escaping ([BookData]) -> Void) {
        
        guard let URL = URL(string: "https://dapi.kakao.com/v3/search/book?query=book") else { return }
        
        var request = URLRequest(url: URL)
        request.httpMethod = "GET"
        request.setValue("KakaoAK 88468a6bac6216fe1153fe1025268714", forHTTPHeaderField: "Authorization")
        request.addValue("application/json",
                         forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            let successArrange = (200..<300)
            
            guard error == nil else { return }
            guard let data = data else { return }
            guard let response = response as? HTTPURLResponse else { return }
            guard successArrange.contains(response.statusCode) else { completion([])
                return
            }
            
            do {
                let responseData = try JSONDecoder().decode(BookStoreData.self, from: data)
                completion(responseData.documents)
            } catch {
                print(error)
                completion([])
            }
        }.resume()
    }
}
