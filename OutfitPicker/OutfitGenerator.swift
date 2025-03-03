import Foundation
import UIKit

enum WeatherType: String {
    case hot, cold, rainy, all
}

enum ClothingCategory: String {
    case top, bottom, footwear, accessory
}

enum StyleType: String {
    case formal, casual, sporty, business, streetwear, outdoor, all
}

struct OutfitItem {
    let name: String
    let category: ClothingCategory
    let suitableWeather: [WeatherType] // Now an array
    let styles: [StyleType] // Now an array
    let imageName: String
}

let outfitItems: [OutfitItem] = [
    // Formal Tops
    OutfitItem(name: "Dress Shirt", category: .top, suitableWeather: [.all], styles: [.formal, .business], imageName: "dress_shirt"),
    OutfitItem(name: "Blazer", category: .top, suitableWeather: [.all], styles: [.formal, .business], imageName: "blazer"),

    // Casual Tops
    OutfitItem(name: "T-shirt", category: .top, suitableWeather: [.hot, .all], styles: [.casual, .streetwear], imageName: "T-shirt"),
    OutfitItem(name: "Hoodie", category: .top, suitableWeather: [.cold, .all], styles: [.casual, .streetwear], imageName: "Hoodie"),

    // Bottoms
    OutfitItem(name: "Dress Pants", category: .bottom, suitableWeather: [.all], styles: [.formal, .business], imageName: "dress_pants"),
    OutfitItem(name: "Chinos", category: .bottom, suitableWeather: [.all], styles: [.casual, .business], imageName: "chinos"),
    OutfitItem(name: "Jeans", category: .bottom, suitableWeather: [.all], styles: [.casual, .streetwear], imageName: "jeans"),
    OutfitItem(name: "Shorts", category: .bottom, suitableWeather: [.hot], styles: [.casual, .sporty], imageName: "shorts"),

    // Footwear
    OutfitItem(name: "Dress Shoes", category: .footwear, suitableWeather: [.all], styles: [.formal, .business], imageName: "dress_shoes"),
    OutfitItem(name: "Boots", category: .footwear, suitableWeather: [.cold, .all], styles: [.casual, .streetwear, .outdoor], imageName: "boots"),
    OutfitItem(name: "Sneakers", category: .footwear, suitableWeather: [.all], styles: [.casual, .sporty, .streetwear], imageName: "Sneakers"),

    // Accessories
    OutfitItem(name: "Tie", category: .accessory, suitableWeather: [.all], styles: [.formal, .business], imageName: "Tie"),
    OutfitItem(name: "Scarf", category: .accessory, suitableWeather: [.cold], styles: [.casual, .outdoor], imageName: "Scarf"),
    OutfitItem(name: "Watch", category: .accessory, suitableWeather: [.all], styles: [.casual, .formal], imageName: "Watch"),
    OutfitItem(name: "Sunglasses", category: .accessory, suitableWeather: [.hot], styles: [.casual, .streetwear], imageName: "Sunglasses")
]

func generateOutfitImage(top: OutfitItem?, bottom: OutfitItem?, shoes: OutfitItem?, accessory: OutfitItem?) -> UIImage? {
    // Create a context to draw in
    let size = CGSize(width: 300, height: 500) // Adjust as needed
    UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
    
    // Draw each item's image
    if let top = top, let topImage = UIImage(named: top.imageName) {
        topImage.draw(in: CGRect(x: 75, y: 0, width: 150, height: 150))
    }
    
    if let bottom = bottom, let bottomImage = UIImage(named: bottom.imageName) {
        bottomImage.draw(in: CGRect(x: 75, y: 150, width: 150, height: 200))
    }
    
    if let shoes = shoes, let shoesImage = UIImage(named: shoes.imageName) {
        shoesImage.draw(in: CGRect(x: 100, y: 350, width: 100, height: 100))
    }
    
    if let accessory = accessory, let accessoryImage = UIImage(named: accessory.imageName) {
        accessoryImage.draw(in: CGRect(x: 200, y: 50, width: 75, height: 75))
    }
    
    // Get the composed image
    let composedImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return composedImage
}

func generateOutfit(for weather: WeatherType, style: StyleType) -> (description: String, image: UIImage?) {
    // Filter items that match the weather AND style
    let filteredTops = outfitItems.filter { $0.category == .top &&
                                           ($0.suitableWeather.contains(weather) || $0.suitableWeather.contains(.all)) &&
                                           ($0.styles.contains(style) || $0.styles.contains(.all)) }

    let filteredBottoms = outfitItems.filter { $0.category == .bottom &&
                                              ($0.suitableWeather.contains(weather) || $0.suitableWeather.contains(.all)) &&
                                              ($0.styles.contains(style) || $0.styles.contains(.all)) }

    let filteredShoes = outfitItems.filter { $0.category == .footwear &&
                                            ($0.suitableWeather.contains(weather) || $0.suitableWeather.contains(.all)) &&
                                            ($0.styles.contains(style) || $0.styles.contains(.all)) }

    let filteredAccessories = outfitItems.filter { $0.category == .accessory &&
                                                  ($0.suitableWeather.contains(weather) || $0.suitableWeather.contains(.all)) &&
                                                  ($0.styles.contains(style) || $0.styles.contains(.all)) }

    // Randomly select one item from each category as objects
    let topItem = filteredTops.randomElement()
    let bottomItem = filteredBottoms.randomElement()
    let shoesItem = filteredShoes.randomElement()
    let accessoryItem = Bool.random() ? filteredAccessories.randomElement() : nil
    
    // Generate the outfit description
    var description = "\(topItem?.name ?? "No top available") + \(bottomItem?.name ?? "No bottom available") + \(shoesItem?.name ?? "No shoes available")"
    if let accessory = accessoryItem?.name {
        description += " + \(accessory)"
    }
    
    if weather == .rainy {
        let umbrellaOrRaincoat: String
        if filteredTops.contains(where: { $0.name.contains("Raincoat") }) {
            umbrellaOrRaincoat = "Great choice! You're already dressed for the rain with a raincoat."
        } else if filteredAccessories.contains(where: { $0.name.contains("Umbrella") }) {
            umbrellaOrRaincoat = "Don't forget to take an umbrella with you!"
        } else {
            umbrellaOrRaincoat = "Consider adding a raincoat or carrying an umbrella for the rainy weather."
        }
        
        description += "\n\(umbrellaOrRaincoat)"
    }
    
    // Generate the outfit image
    let outfitImage = generateOutfitImage(top: topItem, bottom: bottomItem, shoes: shoesItem, accessory: accessoryItem)
    
    return (description, outfitImage)
}
