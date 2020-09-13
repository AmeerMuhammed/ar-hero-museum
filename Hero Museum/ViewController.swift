//
//  ViewController.swift
//  Hero Museum
//
//  Created by AmeerMuhammed on 9/12/20.
//  Copyright © 2020 AmeerMuhammed. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        sceneView.autoenablesDefaultLighting = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARImageTrackingConfiguration()
        
        if let imageRef = ARReferenceImage.referenceImages(inGroupNamed: "Heroes", bundle: Bundle.main)
        {
            configuration.trackingImages = imageRef
            configuration.maximumNumberOfTrackedImages = 2
        }
        
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor {
            
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            plane.firstMaterial?.diffuse.contents = UIColor(white: 1, alpha: 0.6)
            let planeNode = SCNNode(geometry: plane)
            planeNode.eulerAngles.x = -Float.pi/2
            
            if(imageAnchor.referenceImage.name=="wallace")
            {
                if let heroIcon = SCNScene(named: "art.scnassets/wallace_sword.scn")
                {
                    if let heroIconNode = heroIcon.rootNode.childNodes.first {
                        heroIconNode.eulerAngles.x = Float.pi/2
                        planeNode.addChildNode(heroIconNode)
                    }
                }
            }
            else if(imageAnchor.referenceImage.name=="alexander") {
                if let heroIcon = SCNScene(named: "art.scnassets/horse.scn")
                {
                    if let heroIconNode = heroIcon.rootNode.childNodes.first {
                        heroIconNode.eulerAngles.x = Float.pi/2
                        planeNode.addChildNode(heroIconNode)
                    }
                }
            }
            
            node.addChildNode(planeNode)
            
            
        }
        
        return node
    }
}
