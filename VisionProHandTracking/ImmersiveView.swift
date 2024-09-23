//
//  ImmersiveView.swift
//  VisionProHandTracking
//
//  Created by Mehrad Faridan on 2024-09-22.
//

import SwiftUI
import RealityKit
import RealityKitContent
import ARKit

struct ImmersiveView: View {
    let handTracking = HandTrackingProvider()
    let session = ARKitSession()

    var body: some View {
        RealityView { content in
            // Add the initial RealityKit content

        } update: { content in

            Task {
               // loop through all anchors given to us by handTracking provider
                for await anchorUpdate in handTracking.anchorUpdates {

                    // grab the indivual anchor from each iteration of the loop
                    let anchor = anchorUpdate.anchor
                    // this is a switch statement where we differntiate the left/right hand
                    switch anchor.chirality {
                    case .left:
                        // left hand code goes here
                        print("Left hand is tracked")
                        break

                    case .right:
                        // right hand code goes here
                        print("Right hand is tracked")
                        break
                        
                    @unknown default:
                        print("Unknown error")
                    }
                }
            }
        }
        // Asyncly run's and ARkit session
        // needs to happen Async NOT on main thread
        .task {
            await runHandTrackingSession()
        }
    }


    /*
     To Enable hand tracking you need to first run an ARkit session
     the function below first checks if the user has hand tracking enebaled
     then will run run an ARkit session
     */
    func runHandTrackingSession() async {
        do {
            if HandTrackingProvider.isSupported {
                try await session.run([handTracking])
                print("Hand tracking initializing in progress.")
            }
            else {
                print("Hand tracking is not supported.")
            }
        }
        catch {
            print("Error during initialization of hand tracking: \(error)")
        }
    }
}

#Preview(immersionStyle: .mixed) {
    ImmersiveView()
        .environment(AppModel())
}
