//
//  CombineViewModel.swift
//  CombineNow (iOS)
//
//  Created by Rohit Saini on 17/12/20.
//

import Combine
import Foundation
final class CombineViewModel:ObservableObject{
    @Published var isDarkMode = false
    @Published var comments = [Comment]()
    
    private let url = "https://jsonplaceholder.typicode.com/comments"
    private var task: Cancellable? = nil
    
    init(){
        fetchData()
    }
    
    private func fetchData(){
        guard let url = URL(string: url) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        self.task = URLSession.shared.dataTaskPublisher(for: request)
            .map{ $0.data }
            .decode(type: [Comment].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (err) in
                print(err)
            }, receiveValue: { (response) in
                self.comments = response
            })
        
    }
}


// MARK: - PageResponseElement
struct Comment: Codable,Identifiable {
    let postID, id: Int
    let name, email, body: String
    
    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case id, name, email, body
    }
}




