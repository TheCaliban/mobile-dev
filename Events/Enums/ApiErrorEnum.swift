import Foundation

// Describe the error for API
enum ApiError: Error {
    case httpError(Error)
    case apiError(String, String)
    case parseError(Error, String)
}
