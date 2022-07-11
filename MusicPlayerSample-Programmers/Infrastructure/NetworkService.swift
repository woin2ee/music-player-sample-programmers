//
//  NetworkService.swift
//  MusicPlayerSample-Programmers
//
//  Created by Jaewon on 2022/07/11.
//

import Foundation
import Alamofire

protocol NetworkService {
    func request(url: URL, _ completion: @escaping (Music) -> Void)
}

final class DefaultNetworkService: NetworkService {
    
    func request(url: URL, _ completion: @escaping (Music) -> Void) {
        AF.request(url).responseDecodable(of: MusicResponseDTO.self) { response in
            guard let musicResponseDTO = response.value else { return }
            completion(musicResponseDTO.toEntity())
        }
    }
}
