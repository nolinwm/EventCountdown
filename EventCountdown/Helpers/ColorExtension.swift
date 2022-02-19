//
//  ColorExtension.swift
//  EventCountdown
//
//  Modified for ease of use with CoreData. Allows nil hex value and invalid hex value, returns black in both cases.
//

import Foundation
import SwiftUI

extension Color {
    // Takes hex code in the format of #000000
    init(hex: String?) {
        guard let hex = hex else {
            self.init(.sRGB, red: 0, green: 0, blue: 0, opacity: 1)
            return
        }
        
        var str = hex
        if str.hasPrefix("#") {
            str.removeFirst()
        }
        
        let scanner = Scanner(string: str)
        var color: UInt64 = 0
        scanner.scanHexInt64(&color)
        
        if str.count == 6 {
            let red = Double(Int(color >> 16) & 0x0000FF) / 255
            let green = Double(Int(color >> 8) & 0x0000FF) / 255
            let blue = Double(Int(color) & 0x0000FF) / 255
            self.init(.sRGB, red: red, green: green, blue: blue, opacity: 1)
        } else {
            self.init(.sRGB, red: 0, green: 0, blue: 0, opacity: 1)
            return
        }
    }
    
    // Converts SwiftUI Color to hex code in the format of #000000
    static func convertToHex(_ color: Color) -> String {
        let components = color.cgColor?.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0

        let hexString = String.init(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
        return hexString
     }
}
