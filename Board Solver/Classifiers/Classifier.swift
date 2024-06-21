//
//  Classifier.swift
//  Board Solver
//
//  Created by Alex Mattoni on 6/18/24.
//

import CoreML
import Vision
import CoreImage

struct Classifier {
    
    static func createImageClassifier() -> VNCoreMLModel
    {
        // Use a default model configuration.
        let defaultConfig = MLModelConfiguration()

        // Create an instance of the image classifier's wrapper class.
        let imageClassifierWrapper = try? connect4(configuration: defaultConfig)

        guard let imageClassifier = imageClassifierWrapper else {
            fatalError("App failed to create an image classifier model instance.")
        }

        // Get the underlying model instance.
        let imageClassifierModel = imageClassifier.model

        // Create a Vision instance using the image classifier's model instance.
        guard let imageClassifierVisionModel = try? VNCoreMLModel(for: imageClassifierModel) else {
            fatalError("App failed to create a `VNCoreMLModel` instance.")
        }

        return imageClassifierVisionModel
    }
    
    private static let imageClassifier = createImageClassifier()
    
    private(set) var results: String?
    
    mutating func detect(ciImage: CIImage)
    {
        
        print("Creating request")
        let request = VNCoreMLRequest(model: Classifier.imageClassifier.self)
        
        print("Creating handler")
        let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        
        print("Performing request")
        try? handler.perform([request])
        
        print("Getting results")
        guard let results = request.results as? [VNClassificationObservation] else
        {
            print("Error getting results")
            return
        }
        
        print("Results should be here by now")
        if let firstResult = results.first
        {
            self.results = firstResult.identifier
        }
        
    }
    
}

