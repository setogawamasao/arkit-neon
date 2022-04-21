//
//  ViewController.swift
//  bloom-spike
//
//  Created by 瀬戸川将夫 on 2022/04/17.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        let scene = SCNScene()
        sceneView.scene = scene
        //sceneView.autoenablesDefaultLighting = true
                    
        let node = SCNNode()
        node.geometry = SCNBox(width: 0.3, height: 0.3, length: 0.3, chamferRadius: 0.3)
        node.geometry?.firstMaterial?.diffuse.contents = UIColor(hue: 0.5, saturation: 1, brightness: 1, alpha: 0.0)
        node.position = SCNVector3(0, 0, -0.7)

        
        let textNode1 = SCNNode()
        let textGeo1 = SCNText(string: "MASAO",extrusionDepth: 1)
        //textGeo1.font = UIFont(name: "HiraginoSans-W6", size: 1);
        textNode1.geometry = textGeo1
        textNode1.position = SCNVector3(0, 0, 0)
        textNode1.geometry?.firstMaterial?.diffuse.contents = UIColor(hue: 0.5, saturation: 0.1, brightness: 1, alpha: 1)
        textNode1.scale = SCNVector3(0.05,0.05,0.99);
        let (min1, max1) = (textNode1.boundingBox)
        let w1 = Float(max1.x - min1.x)
        let h1 = Float(max1.y - min1.y)
        textNode1.pivot = SCNMatrix4MakeTranslation(w1/2 + min1.x, h1/2 + min1.y, 0)
        textNode1.scale = SCNVector3(0.01,0.01,0.01)

        
        let textNode2 = SCNNode()
        let textGeo2 = SCNText(string: "MASAO",extrusionDepth: 1)
        //textGeo2.font = UIFont(name: "HiraginoSans-W6", size: 1.01);
        textNode2.geometry = textGeo2
        textNode2.position = SCNVector3(0, 0, 0)
        textNode2.geometry?.firstMaterial?.diffuse.contents = UIColor(hue: 0.5, saturation: 1, brightness: 1, alpha: 0.8)
        textNode2.scale = SCNVector3(0.05,0.05,0.99);
        let (min2, max2) = (textNode2.boundingBox)
        let w2 = Float(max2.x - min2.x)
        let h2 = Float(max2.y - min2.y)
        textNode2.pivot = SCNMatrix4MakeTranslation(w2/2 + min2.x, h2/2 + min2.y, 0)
        textNode2.filters = addBloom()
        textNode2.scale = SCNVector3(0.01,0.01,0.01)
        
        node.addChildNode(textNode1)
        node.addChildNode(textNode2)
        sceneView.scene.rootNode.addChildNode(node)
        
        let rotate = SCNAction.rotate(by: 2 * .pi, around: SCNVector3(0, 1, 0), duration: 5)
        //node.runAction(SCNAction.repeatForever(rotate))
        
    }
    
    func addBloom() -> [CIFilter]? {
        let bloomFilter = CIFilter(name:"CIBloom")!
        bloomFilter.setValue(6.0, forKey: "inputIntensity")
        bloomFilter.setValue(15.0, forKey: "inputRadius")
        return [bloomFilter]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
