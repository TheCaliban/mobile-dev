import Foundation


/// Service responsible to interact with Airtables API
class ApiService {
    private static var token = "keyJlzR5fTvTIZW3I"
    
    // Need to pass the type as an argument because type serialization
    static func call<T: Decodable>(_ returning: T.Type, url: String, completionHandler: @escaping (T?) -> Void, errorHandler: @escaping (  ApiError?) -> Void) {
        let url = URL(string: url)
        
        // Set the URL and the Bearer
        var request = URLRequest(url: url!) 
        request.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let error = error {
                // Return the HTTP Client error
                errorHandler(ApiError.httpError(error))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                // API Error thrown
                let httpCode: String = String((response as? HTTPURLResponse)?.statusCode ?? 0)
                errorHandler(ApiError.apiError(httpCode, String(bytes: data ?? Data(), encoding: .utf8) ?? ""))
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let dateFormatter = DateFormatter()
                    // Dates are in this format: 2019-11-15T14:30:00.000Z
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.sssZ"
                    dateFormatter.locale = Locale(identifier: "en_US")
                    dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                    decoder.dateDecodingStrategy = .formatted(dateFormatter)
                    
                    let decoded = try decoder.decode(T.self, from: data)
                    completionHandler(decoded)
                } catch {
                    // Decodable error
                    errorHandler(ApiError.parseError(error, String(bytes: data, encoding: .utf8) ?? ""))
                }
            }
        })
        
        // Start the async job
        task.resume()
    }
}
