import SwiftUI

struct StrengthSegmentView: View {
    @ObservedObject var viewModel: ZodiacViewModel

    var body: some View {
        VStack {
            Text("Elements")
                .font(.title)
                .fontWeight(.bold)
                .padding(.vertical)

            HStack {
                ElementDetailView(date: viewModel.firstBirthdate, viewModel: viewModel)
                if viewModel.firstBirthdate != viewModel.secondBirthdate {
                    ElementDetailView(date: viewModel.secondBirthdate, viewModel: viewModel)
                }
            }
            
            Text(viewModel.elementInteractionDescription())
                .fixedSize(horizontal: false, vertical: true)  // Allows text to expand vertically
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .font(.body)

        }
        .padding()
    
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct ElementDetailView: View {
    var date: Date
    var viewModel: ZodiacViewModel

    var body: some View {
        let sign = viewModel.sign(for: Calendar.current.component(.year, from: date))
        
        return VStack {
            Image(sign.element.lowercased())
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
            
            Text(sign.element)
                .font(.headline)
                .foregroundColor(.secondary)
        }
    }
}

extension ZodiacViewModel {
    func elementInteractionDescription() -> String {
        let firstSign = sign(for: Calendar.current.component(.year, from: firstBirthdate))
        let secondSign = sign(for: Calendar.current.component(.year, from: secondBirthdate))
        return zodiacModel.interactionDescription(forElement: firstSign.element, and: secondSign.element)
    }
}

// Ensure you have a preview setup that provides a valid ViewModel instance
struct StrengthSegmentView_Previews: PreviewProvider {
    static var previews: some View {
        StrengthSegmentView(viewModel: ZodiacViewModel())
    }
}
