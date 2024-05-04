import Foundation

struct ZodiacSign {
    let animal: String
    let element: String
    let yinYang: String
}




class ZodiacModel {
    private let cycleStartYear = 1924 // A year of Rat and Wood element to start the cycle
    private let animals = ["Rat", "Ox", "Tiger", "Rabbit", "Dragon", "Snake", "Horse", "Goat", "Monkey", "Rooster", "Dog", "Pig"]
    private let elements = ["Wood", "Wood", "Fire", "Fire", "Earth", "Earth", "Metal", "Metal", "Water", "Water"]
    private let personalities: [String: [String]] = [
          "Rat": ["Adaptable", "Charming", "Creative", "Sociable"],
          "Ox": ["Reliable", "Steady", "Determined", "Honest"],
          "Tiger" : ["Confident", "Adventurous", "Passionate", "Impulsive"],
          "Rabbit" : ["Sensitive", "Compassionate", "Cautious", "Artistic"],
          "Dragon" : ["Charismatic", "Intelligent", "Enthusiastic", "Ambitious"],
          "Snake" : ["Wise", "Mysterious", "Intuitive", "Prudent"],
          "Horse" : ["Energetic", "Independent", "Impatient", "Cheerful"],
          "Goat" : ["Peaceful", "Sympathetic", "Creative", "Timid"],
          "Monkey" : ["Innovative", "Lively", "Clever", "Playful"],
          "Rooster" : ["Observant", "Hardworking", "Courageous", "Confident"],
          "Dog" : ["Loyal", "Honest", "Kind", "Cautious"],
          "Pig" : ["Generous", "Sincere", "Sociable", "Indulgent"]
      ]
    
    private let elementInteractions: [String: String] = [
        "Wood-Wood": "Two Wood elements together symbolize a relationship marked by growth and mutual support, fostering a nurturing environment that leads to prosperity.",
        "Wood-Fire": "Wood fuels Fire, representing a relationship where one partner energizes and supports the other, creating warmth and passion",
        "Wood-Earth": "Wood depleting Earth by drawing nutrients suggests a relationship needing balance, as one partner may drain the other if not careful.",
        "Wood-Metal": "Metal cuts Wood, indicating a relationship where one partner shapes or significantly influences the growth and direction of the other.",
        "Wood-Water": "Water nourishes Wood, suggesting a harmonious relationship that enhances growth, resilience, and flexibility.",
        "Fire-Wood": "Fire consuming Wood represents a dynamic relationship where one partner’s energy and passion can either support or overwhelm the other.",
        "Fire-Fire": "Two Fire elements together can create an intensely passionate but potentially volatile relationship, needing careful management to avoid burnout.",
        "Fire-Earth": "Fire enriches Earth with ash, symbolizing a relationship that transforms and enhances each partner, leading to shared growth and fertility.",
        "Fire-Metal": "Fire testing Metal until it melts represents a relationship where resilience is tested by adversity, leading to transformation and new forms.",
        "Fire-Water": "Water extinguishing Fire depicts a challenging relationship with inherent opposition, where differences need to be managed to avoid extinguishing each other’s energy.",
        "Earth-Wood": "Earth providing nutrients to Wood symbolizes a supportive relationship where one partner provides the foundation for the other’s growth.",
        "Earth-Fire": "EEarth being scorched by Fire suggests a transformative relationship where one partner’s intensity can lead to significant changes in the other.",
        "Earth-Earth": "Two Earth elements together indicate a relationship that values stability and security, often resistant to change but providing a solid foundation.",
        "Earth-Metal": "Earth containing Metal represents a nurturing relationship, where one partner supports and enhances the other’s strengths and potentials.",
        "Earth-Water": "Water shaping Earth symbolizes a relationship where adaptability and change are prevalent, helping each other grow and reshape.",
        "Metal-Wood": "Metal shaping Wood suggests a relationship where one partner has a significant and often constructive influence on the other, guiding growth and development.",
        "Metal-Fire": "Metal withstanding Fire indicates a relationship where resilience is tested by passion and intensity, potentially leading to a transformative outcome.",
        "Metal-Earth": "Metal extracted from Earth represents a relationship where one partner relies on the other for support and sustenance, strengthening the bond.",
        "Metal-Metal": "Two Metal elements together depict a strong, resilient relationship, where both partners share a tough but potentially inflexible bond.",
        "Metal-Water": "Water corroding Metal suggests a relationship that may face challenges due to persistent issues, requiring care to prevent deterioration.",
        "Water-Wood": "Water nourishing Wood in a relationship signifies one partner enhancing and supporting the growth and flexibility of the other.",
        "Water-Fire": "Water quenching Fire depicts a relationship where emotional or rational differences can lead to conflicts, requiring understanding to coexist",
        "Water-Earth": "Water carrying Earth materials indicates a relationship that facilitates movement and change, helping each other navigate life’s journey.",
        "Water-Metal": "Water corroding Metal suggests a relationship where subtle influences can lead to significant changes, requiring maintenance to preserve harmony.",
        "Water-Water": "Two Water elements together depict a relationship with deep emotional bonds and understanding, but with a risk of losing individual identity."
    ]

    
    
    
    func sign(forYear year: Int) -> ZodiacSign {
        let animalIndex = (year - cycleStartYear) % 12
        let elementIndex = (year - cycleStartYear) % 10 // Because the element cycle is 10 years
        let yinYang = ((year - cycleStartYear) % 2 == 0) ? "Yang" : "Yin"
        
        let animal = animals[animalIndex]
        let element = elements[elementIndex]
        
        return ZodiacSign(animal: animal, element: element, yinYang: yinYang)
    }
    
    // Function to get personality traits for an animal
       func personalityTraits(forAnimal animal: String) -> [String] {
           return personalities[animal] ?? ["Information not available"]
       }
    
    func interactionDescription(forElement firstElement: String, and secondElement: String) -> String {
            let key = "\(firstElement)-\(secondElement)"
            return elementInteractions[key] ?? "No specific interaction described for \(firstElement) and \(secondElement)."
        }
    
    
    // Example of how to structure the compatibility matrix
    private let compatibilityMatrix: [String: [String: String]] = [
        "Rat": ["Rat": "Average", "Ox": "Perfect match", "Dragon": "Perfect Match", "Snake":"You guys are a good friend :')", "Horse": "Worst", "Goat":"Can be match, but can be Enemy", "Monkey":"Complementary", "Rooster":"Worst", "Dog":"Complementary", "Pig":"Complementary", "Tiger":"Average", "Rabbit":"Perfect match"],
        "Ox": ["Rat": "Perfect match", "Ox": "Average","Tiger":"Worst","Rabbit":"Complementary", "Dragon": "Worst", "Snake":"Complementary", "Horse": "Worst", "Goat":"Worst", "Monkey":"Perfect match", "Rooster":"Perfect match", "Dog":"Average", "Pig":"Can be match, but can be Enemy"],
        "Tiger": ["Rat": "Average", "Ox": "Worst","Tiger":"Worst","Rabbit":"Average", "Dragon": "Perfect match", "Snake":"Worst", "Horse": "Perfect match", "Goat":"You guys are a good friend :')", "Monkey":"Worst", "Rooster":"Complementary", "Dog":"Complementary", "Pig":"Perfect match"],
        "Rabbit": ["Rat": "Perfect match", "Ox": "Complementary","Tiger":"Average","Rabbit":"Average", "Dragon": "Average", "Snake":"Worst", "Horse": "Average", "Goat":"Perfect match", "Monkey":"Perfect match", "Rooster":"Worst", "Dog":"Perfect match", "Pig":"Perfect match"],
        "Dragon": ["Rat": "Perfect match", "Ox": "Worst","Tiger":"Perfect match","Rabbit":"Average", "Dragon": "You guys are a good friend :')", "Snake":"Perfect match", "Horse": "Average", "Goat":"Worst", "Monkey":"Complimentary", "Rooster":"Complimentary", "Dog":"Worst", "Pig":"You guys are a good friend :')"],
        "Snake": ["Rat": "You guys are a good friend :')", "Ox": "Complimentary","Tiger":"Worst","Rabbit":"Worst", "Dragon": "Perfect match", "Snake":"Worst", "Horse": "You guys are a good friend :')", "Goat":"Worst", "Monkey":"You guys are a good friend :')", "Rooster":"Perfect match", "Dog":"Average", "Pig":"Worst"],
        "Horse": ["Rat": "Worst", "Ox": "Worst","Tiger":"Perfect match","Rabbit":"Average", "Dragon": "Average", "Snake":"You guys are a good friend :')", "Horse": "Worst", "Goat":"Perfect match", "Monkey":"Average", "Rooster":"Worst", "Dog":"Average", "Pig":"Complimentary"],
        "Goat": ["Rat": "Can be match, but can be Enemy", "Ox": "Worst","Tiger":"You guys are a good friend :')","Rabbit":"Perfect match", "Dragon": "Worst", "Snake":"Worst", "Horse": "Perfect match", "Goat":"Complimentary", "Monkey":"Complimentary", "Rooster":"Average", "Dog":"Worst", "Pig":"Perfect match"],
        "Monkey": ["Rat": "Complimentary", "Ox": "Perfect match","Tiger":"Worst","Rabbit":"Perfect match", "Dragon": "Complimentary", "Snake":"You guys are a good friend :')", "Horse": "Average", "Goat":"Complimentary", "Monkey":"You guys are a good friend :')", "Rooster":"Average", "Dog":"Complimentary", "Pig":"Worst"],
        "Rooster": ["Rat": "Worst", "Ox": "Perfect match","Tiger":"Complimentary","Rabbit":"Worst", "Dragon": "Complimentary", "Snake":"Perfect match", "Horse": "Worst", "Goat":"Average", "Monkey":"Average", "Rooster":"Worst", "Dog":"Worst", "Pig":"Average"],
        "Dog": ["Rat": "Complimentary", "Ox": "Average","Tiger":"Complimentary","Rabbit":"Perfect match", "Dragon": "Worst", "Snake":"Average", "Horse": "Average", "Goat":"Worst", "Monkey":"Complimentary", "Rooster":"Worst", "Dog":"Average", "Pig":"Complimentary"],
        "Pig": ["Rat": "Complimentary", "Ox": "Can be match, but can be Enemy","Tiger":"Perfect match","Rabbit":"Perfect match", "Dragon": "You guys are a good friend :')", "Snake":"Worst", "Horse": "Complimentary", "Goat":"Perfect match", "Monkey":"Worst", "Rooster":"Average", "Dog":"Complimentary", "Pig":"You guys are a good friend :')"],
    ]


    func getCompatibilityBetween(_ firstAnimal: String, _ secondAnimal: String) -> String {
        return compatibilityMatrix[firstAnimal]?[secondAnimal] ?? "Compatibility data not available"
    }

}
