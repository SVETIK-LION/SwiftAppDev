import UIKit

protocol AppTheme {
    var backgroundColor: UIColor { get }
    var textColor: UIColor { get }
}

final class ColorTheme {
    
    static var currentTheme: AppTheme = LightTheme()
}

final class LightTheme: AppTheme {
    var backgroundColor: UIColor = .white
    var textColor: UIColor = .black
}

final class DarkTheme: AppTheme {
    var backgroundColor: UIColor = .darkGray
    var textColor: UIColor = .white
}

final class BlueTheme: AppTheme {
    var backgroundColor: UIColor = .blue
    var textColor: UIColor = .white
}
