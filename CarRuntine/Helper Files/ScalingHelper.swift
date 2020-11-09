
import Foundation
import SpriteKit

//Responsible for responsive bahaviour of all menu scenes on all devices

class ScalingHelper {
    
    func load (layerFile: String, menuLayer: Layer) -> SKNode? {
        
        if let menuLayerNode = SKSpriteNode.unarchiveFromFile(file: layerFile) {
            
            //Following variables needed for accurate menu responsiveness on all devices
            let screenSize = UIScreen.main.bounds
            let screenWidth = screenSize.width
            let screenHeight = screenSize.height
            
            //Default values
            var xPosition: CGFloat
            xPosition = 0
            var yPosition: CGFloat
            yPosition = 0
            var scaleRatio: Double
            scaleRatio = 1
            var xpositionThreshold: Double
            xpositionThreshold = 0
            var ypositionThreshold: Double
            ypositionThreshold = 0
            var defaultRatio: Double
            defaultRatio = 1334/750
            
            //TODO maybe better in class gameConstants
            var xSceneSize: Double
            xSceneSize = 1334
            var ySceneSize: Double
            ySceneSize = 750
            
           
            var screenRatio: Double
                screenRatio = Double(screenWidth/screenHeight)
            
            
            //smaller then default if height is getting bigger then 16:9 ratio (e.g. 4:3)
            if (screenRatio < defaultRatio){
                //e.g. IPad (Ratio 4:3)
                scaleRatio = (screenRatio/defaultRatio)
                
                //Calculate X Position for button layer
                xpositionThreshold = ((xSceneSize-scaleRatio*xSceneSize)/2)/xSceneSize
                xPosition = CGFloat(xpositionThreshold*xSceneSize)
                //Calculate Y Position for button layer
                ypositionThreshold = ((ySceneSize-scaleRatio*ySceneSize)/2)/ySceneSize
                yPosition = CGFloat(ypositionThreshold*ySceneSize)
               
            } else {
                //e.g. IPhone 11 (Ratio 21:9)
                scaleRatio = (defaultRatio/screenRatio)
                
                xpositionThreshold = ((xSceneSize-scaleRatio*xSceneSize)/2)/xSceneSize
                xPosition = CGFloat(xpositionThreshold*xSceneSize)
                //Calculate Y Position for button layer
                ypositionThreshold = ((ySceneSize-scaleRatio*ySceneSize)/2)/ySceneSize
                yPosition = CGFloat(ypositionThreshold*ySceneSize)
               
            }
            //Set correct position
            menuLayerNode.position = CGPoint(x: xPosition, y: yPosition)
            menuLayerNode.setScale(CGFloat(scaleRatio))
            //Ad menu layer as child
            menuLayer.addChild(menuLayerNode)
            
             return menuLayerNode
            }
        return nil
    }
    
}
