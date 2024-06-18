//
//  ContentView.swift
//  Board Solver
//
//  Created by Henry Robbins on 6/4/24.
//

import SwiftUI
import CoreML
import Vision

struct ContentView: View
{
    @State private var viewModel = ViewModel()

    var body: some View
    {
        ZStack
        {
            CameraView(image: $viewModel.currentFrame, isLocked: $viewModel.isLocked)
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            VStack {
                Spacer()
                
                BoardView()
                    .padding(.bottom, 35)
                
                HStack{
                    Button {
                        print("scanning")
                    } label: {
                        Label("", image: "scan_prompt")
                    }
                    .frame(maxWidth: 175)
                    Button {
                        print("locking")
                        viewModel.toggleLock()
                    } label: {
                        Label("", image: "lock_prompt")
                    }
                    .frame(maxWidth: 175)
                }
                .padding()
            }
            .padding()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}