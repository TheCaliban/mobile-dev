import Foundation
import UIKit
import SwiftUI


class ColorUtils {
    
    /// Get a color based on the userId
    /// - Parameter userId: userId used as a hash
    /// - Returns: a Color based on the hash
    static func newColorFromId (userId: String) -> Color {
        
        // Generate unique HEX string from user ID
        let colorNum = abs(userId.hashValue) % (256*256*256)
        
        // Convert unique HEX string to RGB
        let colorRed = CGFloat(colorNum >> 16) / 255.0
        let colorGreen = CGFloat((colorNum & 0x00FF00) >> 8) / 255.0
        let colorBlue = CGFloat(colorNum & 0x0000FF) / 255.0
        
        // Return new Color from generated color
        return Color(
            UIColor(red: colorRed, green: colorGreen, blue: colorBlue, alpha: 1.0)
        )
    }
}
