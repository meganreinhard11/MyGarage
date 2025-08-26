
import SwiftUI

struct TireProductCard: View {
    var title: String
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image("tires_hero").resizable().scaledToFill().frame(height: 180).clipShape(RoundedRectangle(cornerRadius: 16)).overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.black.opacity(0.05)))
            Text(title).font(.title3).bold()
            HStack { Label("16–21\"", systemImage: "ruler"); Spacer(); Label("Winter", systemImage: "snowflake"); Spacer(); Label("106 mph", systemImage: "gauge.medium") }.foregroundStyle(.secondary)
        }.padding().background(RoundedRectangle(cornerRadius: 22).fill(Color(.systemBackground)).shadow(radius: 6))
    }
}
