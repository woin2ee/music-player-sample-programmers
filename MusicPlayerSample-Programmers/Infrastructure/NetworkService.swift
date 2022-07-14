//
//  NetworkService.swift
//  MusicPlayerSample-Programmers
//
//  Created by Jaewon on 2022/07/11.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidURL(String)
    case failDecoding(String)
}

protocol NetworkService {
    func request(_ completion: @escaping (Result<Music, NetworkError>) -> Void)
}

final class DefaultNetworkService: NetworkService {
    
    func request(_ completion: @escaping (Result<Music, NetworkError>) -> Void) {
        guard let url = URL(string: "https://grepp-programmers-challenges.s3.ap-northeast-2.amazonaws.com/2020-flo/song.json")
        else { return completion(.failure(.invalidURL("음악을 불러오지 못했습니다."))) }
        
        AF.request(url).responseDecodable(of: MusicResponseDTO.self) { response in
            guard let musicResponseDTO = response.value
            else { return completion(.failure(.failDecoding("음악을 불러오지 못했습니다."))) }
            
            completion(.success(musicResponseDTO.toEntity()))
        }
    }
}
