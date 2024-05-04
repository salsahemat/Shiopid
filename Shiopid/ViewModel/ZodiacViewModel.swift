import Foundation
import Combine

class ZodiacViewModel: ObservableObject {
    // Published properties that the View can bind to
    @Published var firstBirthdate: Date
    @Published var secondBirthdate: Date

    @Published var compatibilityDescription: String?
    @Published var detailedDescriptions: [String] = []
    var zodiacModel = ZodiacModel()
//    // Reference to your ZodiacModel
//    private var zodiacModel = ZodiacModel()

    init() {
        // Initialize the birthdates with a default value, e.g., today's date
        firstBirthdate = Date()
        secondBirthdate = Date()
    }

    func calculateCompatibility() {
        let firstSign = zodiacModel.sign(forYear: Calendar.current.component(.year, from: firstBirthdate))
        let secondSign = zodiacModel.sign(forYear: Calendar.current.component(.year, from: secondBirthdate))

        let compatibilityResult = zodiacModel.getCompatibilityBetween(firstSign.animal, secondSign.animal)
        compatibilityDescription = "\(compatibilityResult)"
    }

    // Ensure this method is correctly defined
    func personalityTraits(for animal: String) -> [String] {
        return zodiacModel.personalityTraits(forAnimal: animal)
    }



    func sign(for year: Int) -> ZodiacSign {
            return zodiacModel.sign(forYear: year)
        }
    

}
