import SwiftUI
import SDWebImageSwiftUI
import AVFoundation


struct ContentView: View {
    @StateObject var viewModel = ZodiacViewModel() // 1
    
    @State private var showingFirstDatePicker = false
    @State private var showingSecondDatePicker = false
    @State private var navigateToResult = false
    @State private var isLoading = false  // State to control loading indicator

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                // Shiopid title
                Text("Shiopid")
                    .font(Font.custom("Hanalei Fill", size: 24))
                    .foregroundColor(Color(red: 0.59, green: 0.05, blue: 0.05))
                    .padding(.bottom)
                
                // Top graphic
                Image("matchimg")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                // Custom date picker fields
                Group {
                    DateInputField(label: "Your birthdate", date: $viewModel.firstBirthdate, showingPicker: $showingFirstDatePicker) // 2
                    DateInputField(label: "Your soulmate's birthdate", date: $viewModel.secondBirthdate, showingPicker: $showingSecondDatePicker) // 3
                }
                .padding(.horizontal)
                
                // Match Now button
                Button("Match Now") {
                    SoundManager.shared.playSound(named: "matchSound.mp3")
                    withAnimation {
                                                isLoading = true
                                            }
                                            viewModel.calculateCompatibility()
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {  // Simulate network delay
                                                isLoading = false
                                                navigateToResult = true
                                            }
                }
                .font(Font.custom("Noto Sans", size: 20).weight(.heavy))
                .foregroundColor(Color.white)
                .frame(width: 176, height: 56)
                .background(Color(red: 0.67, green: 0.16, blue: 0.18))
                .cornerRadius(40)
                .shadow(color: Color(red: 0.86, green: 0.56, blue: 0.47, opacity: 1), radius: 6.90, x: 3, y: 5)
                .padding(.top)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .edgesIgnoringSafeArea(.all)
            .navigationDestination(isPresented: $navigateToResult) {
                ResultView(viewModel: viewModel) // 5
            }
            if isLoading {
                WebImage(url: Bundle.main.url(forResource: "drumroll", withExtension: "gif"))  // Adjust to correct path if needed
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .transition(.fade(duration: 0.5))
                    .zIndex(1)
//                ProgressView()
//                    .progressViewStyle(CircularProgressViewStyle(tint: .red))
//                    .scaleEffect(2.0)
//                    .zIndex(1)
            }
        }
    }
}

struct DateInputField: View {
    var label: String
    @Binding var date: Date
    @Binding var showingPicker: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text(label)
                    .foregroundColor(Color(red: 0.67, green: 0.13, blue: 0.18))
                Spacer()
                Text(date, style: .date)
                    .foregroundColor(Color(red: 0.67, green: 0.13, blue: 0.18))
            }
            .padding()
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color(red: 0.67, green: 0.13, blue: 0.18), lineWidth: 1)
            )
            .onTapGesture {
                showingPicker.toggle()
            }
            
            if showingPicker {
                DatePicker("", selection: $date, displayedComponents: .date)
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                    .accentColor(Color(red: 0.67, green: 0.13, blue: 0.18))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
