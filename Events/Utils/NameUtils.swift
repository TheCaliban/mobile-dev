import Foundation

class NameUtils {
    
    /// Get initials from a given Name
    /// - Parameter name: name to parse
    /// - Returns: initials
    static func initialsFromName(name: String) -> String {
        
        var initials = ""
        
        // Words to ignore
        let ignore = ["of", "the", "a", "for", "an"]

        // Iterating through the words in the name
        for word in name.split(separator: " ") {
            if (!ignore.contains(word.lowercased())) {
                initials = initials + String(word.first!)
            }
        }

        // Return uppercased initials string
        return initials.uppercased()
    }
}
