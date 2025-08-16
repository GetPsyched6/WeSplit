//
//  ContentView.swift
//  WeSplit
//
//  Created by Roshin Nishad on 8/15/25.
//

import SwiftUI

struct ContentView: View {
  @FocusState private var amountIsFocused: Bool
  @State private var checkAmount = 0.0
  @State private var noOfPeople = 2
  @State private var tipPercentage = 20
  let tipPercentages = [10, 15, 20, 25, 0]
  var totals: Double {
    ((Double(tipPercentage) * checkAmount) / 100) + checkAmount
  }

  var totalPerPerson: Double {
    totals
      / Double(noOfPeople + 2)
  }

  var body: some View {
    NavigationStack {
      Form {
        Section {
          LabeledContent {
            TextField(
              "Amount",
              value: $checkAmount,
              format: .currency(
                code: Locale.current.currency?.identifier
                  ?? "USD"
              )
            ).focused($amountIsFocused)
              .keyboardType(.decimalPad)
          } label: {
            Text("Check Amount")
          }
          Picker("Number of People", selection: $noOfPeople) {
            ForEach(2..<200) {
              Text("\($0) people")
            }
          }
        }
        Section("Tip Percentage") {
          Picker("Tip Percentage", selection: $tipPercentage) {
            ForEach(tipPercentages, id: \.self) {
              Text($0, format: .percent)
            }
          }.pickerStyle(.segmented)
        }
        Section("Result") {
          LabeledContent {
            Text(
              totals,
              format: .currency(
                code: Locale.current.currency?.identifier
                  ?? "USD"
              )
            )
          } label: {
            Text("Total")
          }
          LabeledContent {
            Text(
              totalPerPerson,
              format: .currency(
                code: Locale.current.currency?.identifier
                  ?? "USD"
              )
            )
          } label: {
            Text("Total Per Person")
          }
        }
      }.navigationTitle("WeSplit").toolbar {
        if amountIsFocused {
          Button("Done") {
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
