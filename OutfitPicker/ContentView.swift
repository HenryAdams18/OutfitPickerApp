import SwiftUI

struct ContentView: View {
    @State private var selectedOutfitDescription: String = "Tap to generate an outfit!"
    @State private var selectedOutfitImage: UIImage? = nil  // New state for the image
    @State private var selectedWeather: WeatherType = .all
    @State private var selectedStyle: StyleType = .all
    
    var body: some View {
        VStack {
            Text("Outfit Picker")
                .font(.title)
                .fontWeight(.bold)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // Display the outfit image if available
            if let outfitImage = selectedOutfitImage {
                Image(uiImage: outfitImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 250)
                    .padding()
            }
            
            Text(selectedOutfitDescription)
                .font(.title2)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding()
            
            // Weather selection
            Picker("Select Weather", selection: $selectedWeather) {
                Text("All").tag(WeatherType.all)
                Text("Hot").tag(WeatherType.hot)
                Text("Cold").tag(WeatherType.cold)
                Text("Rainy").tag(WeatherType.rainy)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            HStack {
                // Show either "Select Style" or the selected style
                if selectedStyle == .all {
                    Text("Select Style")
                        .fontWeight(.bold)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                } else {
                    Text("Style: \(selectedStyle.rawValue.capitalized)")
                        .fontWeight(.bold)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                }
                
                // Custom menu picker that only shows a dropdown icon
                Menu {
                    Picker("Style", selection: $selectedStyle) {
                        Text("All").tag(StyleType.all)
                        Text("Formal").tag(StyleType.formal)
                        Text("Casual").tag(StyleType.casual)
                        Text("Sporty").tag(StyleType.sporty)
                        Text("Business").tag(StyleType.business)
                        Text("Outdoor").tag(StyleType.outdoor)
                    }
                    .pickerStyle(.inline)
                    .labelsHidden()
                } label: {
                    Image(systemName: "chevron.down")
                        .foregroundColor(.blue)
                        .frame(width: 40)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                }
                .padding(.leading, 5)
            }
            
            Button(action: {
                // Use tuple destructuring to get both values
                let (description, image) = generateOutfit(for: selectedWeather, style: selectedStyle)
                selectedOutfitDescription = description
                selectedOutfitImage = image
            }) {
                Text("Suggest Outfit")
                    .font(.title2)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
