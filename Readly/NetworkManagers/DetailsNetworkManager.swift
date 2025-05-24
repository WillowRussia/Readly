//
//  DetailsNetworkManager.swift
//  Readly
//
//  Created by Илья Востров on 24.04.2025.
//

import Foundation

class DetailsNetworkManager {
    
    let url = "https://llm.api.cloud.yandex.net/foundationModels/v1/completion"
    static let shared = DetailsNetworkManager()
    private init(){}
    
    func sendRequest(bookTitle title: String, completion: @escaping (Swift.Result<String, Error>) -> Void){
        
        guard let url = URL(string: self.url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Api-Key \(apiKey)", forHTTPHeaderField: "Authorization")
        
        let requestBodyStruct = YandexGPTRequest(modelUri: "gpt://b1g4vp915qu5m5gldom9/yandexgpt-lite",
                                                 completionOptions:
                                                    CompletionOptions(stream: false,
                                                                      temperature: 0.2,
                                                                      maxTokens: "1000",
                                                                      reasoningOptions:
                                                                        ReasoningOptions(mode: "DISABLED")),
                                                 messages: [
                                                    Message(role: "system",
                                                            text: "Напиши краткое описание книги в 3-5 предложений. Используй больше фактов и меньше воды."),
                                                    Message(role: "user",
                                                            text: title)])
        
        do {
            let requestBody = try JSONEncoder().encode(requestBodyStruct)
            request.httpBody = requestBody
        }
        catch {
            print(error.localizedDescription)
        }
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard error == nil else { return }
            guard let data else { return }
            
            do {
                let result = try JSONDecoder().decode(YandexGPTResult.self, from: data)
                completion(.success(result.result.alternatives.first!.message.text))
            }
            catch {
                print(error)
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    func loadCover(url: URL, completion: @escaping (Swift.Result<Data, Error>) -> Void) {
        let request = URLRequest (url: url)
        URLSession.shared.dataTask(with: request) { data, resp, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            guard let httResp = resp as? HTTPURLResponse,
                  httResp.statusCode == 200 else {
                completion(.failure(SaveError.missingCover))
                return
            }
            
            guard let data else {
                completion(.failure(SaveError.missingData))
                return
            }
            
            completion(.success(data))
        }.resume()
    }
}
// MARK: - YandexGPTRequest
struct YandexGPTRequest: Encodable {
    let modelUri: String
    let completionOptions: CompletionOptions
    let messages: [Message]
}

struct CompletionOptions: Encodable {
    let stream: Bool
    let temperature: Double
    let maxTokens: String
    let reasoningOptions: ReasoningOptions
}

struct ReasoningOptions: Encodable {
    let mode: String
}

// MARK: - YandexGPTResult
struct YandexGPTResult: Decodable {
    let result: Result
}

struct Result: Decodable {
    let alternatives: [Alternative]
}

struct Alternative: Decodable {
    let message: Message
}

struct Message: Codable {
    let role, text: String
}
