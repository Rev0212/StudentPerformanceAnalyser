import SwiftUI
import CoreML

struct ContentView: View {
    @State private var hoursStudied: Int64 = 1
    @State private var previousScore: Int64 = 0
    @State private var sleepHours: Double = 0
    @State private var hasExtracurricular: Bool = false
    @State private var questionsPracticed: Int64 = 0
    @State private var performanceIndex: Double = 0

    // Prediction function that uses the model
    func predictPerformance() {
        // Create an instance of StudentPerformance with current data
        let studentData = StudentPerformance(
            hoursStudied: hoursStudied,
            previousScores: previousScore,
            extracurricularActivities: hasExtracurricular,
            sleepHours: Int64(sleepHours),
            questionPapersPracticed: questionsPracticed
        )

        // Call the calculatePerformanceIndex() method to get the predicted performance
        performanceIndex = studentData.calculatePerformanceIndex()
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("STUDY HABITS")) {
                    HStack {
                        Text("Hours Studied")
                        Spacer()
                        Stepper("\(hoursStudied)", value: $hoursStudied, in: 0...12)
                    }

                    HStack {
                        Text("Previous Scores")
                        TextField("Score", value: $previousScore, format: .number)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                    }
                }

                Section(header: Text("HEALTH AND ACTIVITIES")) {
                    VStack(alignment: .leading) {
                        Text("Sleep Hours: \(sleepHours, specifier: "%.f") hours")
                        Slider(value: $sleepHours, in: 0...12, step: 1.0)
                    }

                    Toggle("Participates in Extracurricular Activities", isOn: $hasExtracurricular)
                }

                Section(header: Text("PREPARATION")) {
                    HStack {
                        Text("Papers Practiced")
                        Spacer()
                        Stepper("\(questionsPracticed)", value: $questionsPracticed, in: 0...12)
                    }
                }

                Section(header: Text("PREDICTED PERFORMANCE")) {
                    HStack {
                        Text("Performance Index")
                        Spacer()
                        Text(String(format: "%.2f", performanceIndex))
                            .bold()
                    }
                }

                Section {
                    Button("Predict Performance") {
                        predictPerformance()
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .buttonStyle(.borderless)
                }
            }
            .navigationTitle("Student Performance")
        }
    }
}

#Preview {
    ContentView()
}
