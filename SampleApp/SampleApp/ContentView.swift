//
//  ContentView.swift
//  SampleApp
//
//  Created by Keigo Nakagawa on 2023/09/27.
//

import SwiftUI
import LoggerMacro
import OSLog

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Test") {
                #log(category: "default", type: .debug, message: "test debug", actionHandler: {
                    print("handler action")
                })
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
