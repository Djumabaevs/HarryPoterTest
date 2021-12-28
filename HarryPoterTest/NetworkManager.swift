//
//  NetworkManager.swift
//  HarryPoterTest
//
//  Created by Bakyt Dzhumabaev on 28/12/21.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    private struct Constants {
        static let baseURL = "https://rickandmortyapi.com/api/"
    }
    
    enum endpoints: String {
        case character
        case location
        case episode
        case avatar
    }
    
    private init() {}
    
    // MARK: - Public
    
    public func getAllData(){
        
    }
    
    public func getEpisodesData(
        page: Int, completion: @escaping (Result<PagedEpisode, Error>) -> Void
    ) {
        
        print(URL(string: Constants.baseURL + endpoints.episode.rawValue + "/?page=\(String(page))") ?? "Printed episode url")
        guard let url = URL(string: Constants.baseURL + endpoints.episode.rawValue + "/?page=\(String(page))") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let episodes = try JSONDecoder().decode(PagedEpisode.self, from: data)
                
                completion(.success(episodes))
            }
            catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
        
    }
    
    
    public func getCharactersData(page: Int, completion: @escaping (Result<PagedCharacter, Error>) -> Void
    ) {
        
        print(URL(string: Constants.baseURL + endpoints.character.rawValue + "/?page=\(String(page))") ?? "Printed character url")
        guard let url = URL(string: Constants.baseURL + endpoints.character.rawValue + "/?page=\(String(page))") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let characters = try JSONDecoder().decode(PagedCharacter.self, from: data)
                
                completion(.success(characters))
            }
            catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
        
    }
    
    public func getCharacterImage(character: Character, completion: @escaping (Result<Data, Error>) -> Void
    ) {
        
        if let imgUrl = character.image {
            guard let url = URL(string: imgUrl) else { return }
            
            let task = URLSession.shared.dataTask(with: url) {data, _ , error in
                guard let data = data, error == nil else {
                    return
                }
                
                completion(.success(data))
            }
            
            task.resume()
            
        }
    }
    
    public func getLocationsData(page: Int, completion: @escaping (Result<PagedLocation, Error>) -> Void
    ) {
        
        print(URL(string: Constants.baseURL + endpoints.location.rawValue + "/?page=\(String(page))") ?? "Printed location url")
        guard let url = URL(string: Constants.baseURL + endpoints.location.rawValue + "/?page=\(String(page))") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let locations = try JSONDecoder().decode(PagedLocation.self, from: data)
                
                completion(.success(locations))
            }
            catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
        
    }
    
    public func getEpisodesForCharacter(characterURL: String?, completion: @escaping (Result<Episode, Error>) -> Void) {
        if let url = characterURL {
            guard let url = URL(string: url) else {return}
            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                
                guard let data = data, error == nil else {return}
                
                do {
                    let episode = try JSONDecoder().decode(Episode.self, from: data)
                    completion(.success(episode))
                }
                catch {
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
    }
    
    public func getCharacterInfoForURL(episodeURL: String?, completion: @escaping (Result<Character, Error>) -> Void) {
        let group = DispatchGroup()
        if let url = episodeURL {
            guard let url = URL(string: url) else {return}
            group.enter()
            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                
                guard let data = data, error == nil else {return}
                
                do {
                    var character = try JSONDecoder().decode(Character.self, from: data)
                    
                    NetworkManager.shared.getCharacterImage(character: character) { data in
                        switch data {
                        case .success(let resultImageData):
                            print("getting character image: \(character.image ?? "")")
                            character.imageData = resultImageData
                            completion(.success(character))
                            group.leave()
                        case .failure(let imageError):
                            print(imageError)
                        }
                    }
                }
                catch {
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
    }
}
