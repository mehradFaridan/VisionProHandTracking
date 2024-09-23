//
//  ContentView.swift
//  VisionProHandTracking
//
//  Created by Mehrad Faridan on 2024-09-22.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {

    var body: some View {
        VStack {

            Text("Start Tracking your Hand")

            ToggleImmersiveSpaceButton()
        }
        .padding()
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
        .environment(AppModel())
}
