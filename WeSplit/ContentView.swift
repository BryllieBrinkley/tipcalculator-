import SwiftUI

struct ContentView: View {
    
    @State private var billAmount: Double? = nil
    @State private var numOfPeople = 2
    @State private var tipPercentage = 20
    
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25]
    
    var tipAmount: Double {
        (billAmount ?? 0) * Double(tipPercentage) / 100
    }
    
    var grandTotal: Double {
        (billAmount ?? 0) + tipAmount
    }
    
    var totalPerPerson: Double {
        grandTotal / Double(numOfPeople)
    }
    
    var body: some View {
        NavigationStack {
                Form {
                    Section {
                        
                        HStack {
                            TextField(
                                "Bill Total",
                                value: $billAmount,
                                format: .currency(code: Locale.current.currency?.identifier ?? "USD")
                            )
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocused)
                        }
                        
                        Picker("👯 Number of people", selection: $numOfPeople) {
                            ForEach(1..<21) { num in
                                Text("\(num) people")
                                    .tag(num)
                            }
                        }
                        Section("How much tip do you want to leave? 🤩") {
                            Picker("Tip percentage", selection: $tipPercentage) {
                                ForEach(0..<101) { percent in
                                    Text("\(percent)%")
                                }
                            }
                            .pickerStyle(.navigationLink)
                        }
                    }
                    
                    Section {
                        Text(grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    } header: {
                        Text("Bill Grand Total")
                    }
                    
                    
                    Section {
                        
                        
                        HStack {
                            Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        }
                        
                    } header: {
                        Text("Amount per person")
                    }
                }
                .padding()
                .scrollContentBackground(.hidden)
                .navigationTitle("WeSplit")
                .padding()
                .navigationSubtitle("Split the bill, tip included.")
                .toolbar {
                    if amountIsFocused {
                        Button("done") {
                            amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
