import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany",
                                    "Ireland", "Italy", "Nigeria",
                                    "Poland", "Russia", "Spain",
                                    "UK", "US"].shuffled()
    
    
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var showCountry = ""
    @State private var score = 0

    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.gray, .black]),
                          startPoint: .top, endPoint: .bottom)
                          .edgesIgnoringSafeArea(.all)
        
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }// END-OF-VSTACK

                ForEach(0 ..< 3) { number in Button(action: {
                    self.flagTapped(number: number)
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                                .overlay(Capsule().stroke(Color
                                .black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                    }
                } // END-OF-FOREACH
                Text("Score: \(self.score)").foregroundColor(.white).font(.headline)
                Spacer()
            }// END-OF-VSTACK
        }// END-OF-ZSTACK
            
            // $showingScore is two way binding (changes everywhere)
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle),
                message: Text(showCountry),
                dismissButton:
                .default(Text("Continue")) {
                    self.askQuestion()
                })
        }
    }
    func flagTapped(number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            self.score += 1
        } else {
            scoreTitle = "Wrong."
        }
        
        showCountry = "That's the country of \(countries[number])."

        showingScore = true
    }

    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct COntentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
