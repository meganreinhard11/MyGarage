
import SwiftUI

struct DecimalField: View {
    var title: String
    @Binding var value: String
    var keyboard: UIKeyboardType = .decimalPad
    var body: some View { TextField(title, text: $value).keyboardType(keyboard) }
}
