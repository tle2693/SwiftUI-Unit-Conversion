//
//  ContentView.swift
//  UnitConversion
//
//  Created by Toan Le on 7/28/20.
//  Copyright © 2020 TL. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var inputVal = ""
    @State private var inputUnit = 0
    @State private var outputUnit = 0
    
    let inputUnits = ["m", "km", "feet", "yard", "mile"]
    let outputUnits = ["m", "km", "feet", "yard", "mile"]
    
    var conversedUnit: Measurement<UnitLength> {
        let input = Double(inputVal) ?? 0
        var unitInMeter = 0.00
        //convert input to meter
        if (inputUnit == 0) { //input is in m
            unitInMeter = input
        } else if (inputUnit == 1) { //input in km
            unitInMeter = input * 1000
        } else if (inputUnit == 2) { //input in feet
            unitInMeter = input * 0.3048
        } else if (inputUnit == 3) { //input in yard
            unitInMeter = input * 0.9144
        } else {                     //input in mile
            unitInMeter = input * 1609.344
        }
        //Convert to selected output unit
        //Convert using built-in unit conversion
        let meterBasedUnit = Measurement(value: unitInMeter, unit: UnitLength.meters)
        if (outputUnit == 0) { //output in m
            return meterBasedUnit.converted(to: UnitLength.meters)
        } else if (outputUnit == 1) { //output in km
            return meterBasedUnit.converted(to: UnitLength.kilometers)
        } else if (outputUnit == 2) { //output in feet
            return meterBasedUnit.converted(to: UnitLength.feet)
        } else if (outputUnit == 3) { //output in yard
            return meterBasedUnit.converted(to: UnitLength.yards)
        } else { //output in mile
            return meterBasedUnit.converted(to: UnitLength.miles)
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter the unit value", text: $inputVal)
                        .keyboardType(.decimalPad)
                }
                Section(header: Text("What is the input unit?")) {
                    Picker("Unit Input", selection: $inputUnit) {
                        ForEach(0 ..< inputUnits.count) {
                            Text("\(self.inputUnits[$0])")
                        }
                    }
                .pickerStyle(SegmentedPickerStyle())
                }
                Section (header: Text("What is the unit for output?")) {
                    Picker("Unit Output", selection: $outputUnit) {
                        ForEach(0 ..< outputUnits.count) {
                            Text("\(self.outputUnits[$0])")
                        }
                    }
                .pickerStyle(SegmentedPickerStyle())
                    Text("Your want to convert: \(inputVal)\(inputUnits[inputUnit])")
                }
                Section(header: Text("Converted Value:")) {
                    Text("\(conversedUnit.value, specifier: "%.3f")\(outputUnits[outputUnit])")
                }
            }
            .navigationBarTitle("Unit Conversion")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

