import SwiftUI


struct ResultView: View {
    @State private var selectedSegmentIndex = 0
    @State private var navigateToContent = false
    @ObservedObject var viewModel: ZodiacViewModel
    
    var body: some View {
        ZStack {
            Color(red: 0.67, green: 0.13, blue: 0.18).edgesIgnoringSafeArea(.all)
            VStack {
                
                Spacer().frame(height: 20)
                Text("Result")
                    .font(Font.custom("Noto Sans", size: 24).weight(.bold))
                    .foregroundColor(.white)
                    .padding(.bottom, 20)
                
                HStack(spacing: 20) {
                    ForEach([viewModel.firstBirthdate, viewModel.secondBirthdate], id: \.self) { date in
                        let sign = viewModel.sign(for: Calendar.current.component(.year, from: date))
                        VStack {
                            Image(sign.animal.lowercased())
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 79, height: 107)
                            Text(sign.animal)
                                .font(.headline)
                                .foregroundColor(.white)
                            Text(String(format: "%d", Calendar.current.component(.year, from: date)))
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding(.bottom, 20)
                
                // Display Compatibility Description here
                Text(viewModel.compatibilityDescription ?? "Calculate your compatibility")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .bold()
                    .cornerRadius(10)
                
                VStack {
                    Picker("Choose Segment", selection: $selectedSegmentIndex) {
                        Text("Personality").tag(0)
                        Text("Strength").tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding()
                    
                    if selectedSegmentIndex == 0 { // Personality segment
                        HStack {
                            PersonalityTraitsView(traits: viewModel.personalityTraits(for: viewModel.sign(for: Calendar.current.component(.year, from: viewModel.firstBirthdate)).animal), animal: viewModel.sign(for: Calendar.current.component(.year, from: viewModel.firstBirthdate)).animal)
                            PersonalityTraitsView(traits: viewModel.personalityTraits(for: viewModel.sign(for: Calendar.current.component(.year, from: viewModel.secondBirthdate)).animal), animal: viewModel.sign(for: Calendar.current.component(.year, from: viewModel.secondBirthdate)).animal)
                        }
                        .padding()
                        
                        
                        
                    } else { // Strength segment
                        StrengthSegmentView(viewModel: viewModel)
                    }
                    
                    Button("Match Again") {
                        navigateToContent = true
                    }
                    .font(Font.custom("Noto Sans", size: 20).weight(.heavy))
                    .foregroundColor(Color.white)
                    .frame(maxWidth: 300, minHeight: 44)
                    .background(Color(red: 0.67, green: 0.16, blue: 0.18))
                    .cornerRadius(22)
                    .padding(.bottom, 20)
                }
                .background(Color.white)
                .cornerRadius(15)
                .padding()
                .shadow(radius: 5)
                
                
            }
            // Navigate to ContentView when `navigateToContent` is true
            .fullScreenCover(isPresented: $navigateToContent) {
                ContentView()
            }
        }
    }
    
    struct PersonalityTraitsView: View {
        let traits: [String]
        let animal: String
        
        var body: some View {
            VStack(alignment: .leading) {
                Text(animal.uppercased())
                    .font(.headline)
                    .foregroundColor(Color.red)
                    .padding(.bottom, 2)
                ForEach(traits, id: \.self) { trait in
                    Text(trait)
                        .padding(EdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 10))
                        .cornerRadius(5)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 3)
        }
    }
    
}
    
    
    struct ResultView_Previews: PreviewProvider {
        static var previews: some View {
            ResultView(viewModel: ZodiacViewModel())
        }
    }

