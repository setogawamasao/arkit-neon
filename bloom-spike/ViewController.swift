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
                    
        //let text = "안녕히가세요"
        //let text = "دَرَّسَ"
        //let text = "教える"
        let text = "まさお"
        
        let textGeo1 = SCNText(string: text,extrusionDepth: 1)
        textGeo1.firstMaterial?.diffuse.contents = UIColor(hue: 0.5, saturation: 0.1, brightness: 1, alpha: 1)
        //textGeo1.font = UIFont(name: "HiraginoSans-W6", size: 1);
        
        let textNode1 = SCNNode()
        textNode1.geometry = textGeo1
        textNode1.position = SCNVector3(0, 0, 0)
        textNode1.scale = SCNVector3(0.05,0.05,0.99);
        let (min1, max1) = (textNode1.boundingBox)
        let w1 = Float(max1.x - min1.x)
        let h1 = Float(max1.y - min1.y)
        textNode1.pivot = SCNMatrix4MakeTranslation(w1/2 + min1.x, h1/2 + min1.y, 0)
        textNode1.scale = SCNVector3(0.01,0.01,0.01)

        let textGeo2 = SCNText(string: text,extrusionDepth: 1)
        textGeo2.firstMaterial?.diffuse.contents = UIColor(hue: 0.5, saturation: 1, brightness: 1, alpha: 0.8)
        //textGeo2.font = UIFont(name: "HiraginoSans-W6", size: 1);
        
        let textNode2 = textNode1.clone()
        textNode2.geometry = textGeo2
        textNode2.filters = addBloom()
        
        let node = SCNNode()
        node.position = SCNVector3(0, 0, -0.7)
        node.addChildNode(textNode1)
        node.addChildNode(textNode2)
        sceneView.scene.rootNode.addChildNode(node)
        
        let rotate = SCNAction.rotate(by: 2 * .pi, around: SCNVector3(0, 1, 0), duration: 20)
        node.runAction(SCNAction.repeatForever(rotate))
    }
    
    func addBloom() -> [CIFilter]? {
        let bloomFilter = CIFilter(name:"CIBloom")!
        bloomFilter.setValue(6.0, forKey: "inputIntensity")
        bloomFilter.setValue(15.0, forKey: "inputRadius")
        return [bloomFilter]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
}
