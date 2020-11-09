
import SpriteKit
    
enum KIState {
    case idle, running
}
    
class KI: Player {
    
    var up : SKAction?
    
    var lastSafetyJumpPosition : CGFloat = 0 
        
    func jump(force: Bool) {
        
        let random: Int
        
        if force{
            random = 1
        }
        else{
            random = Int.random(in: 0..<100)
        }
        
        if(random <= GameView.jumpProbability) {
            let waitRandomSec = Double.random(in: 0..<0.3)
            let waitRandom = SKAction.wait(forDuration: waitRandomSec)
            let up = SKAction.moveBy(x: 0.0, y: 150, duration: 0.4)
            let waitNJump = SKAction.sequence([waitRandom, up])
            up.timingMode = .easeOut
            self.turnGravity(on: false)
            self.run(waitNJump)
            self.turnGravity(on: true)
        }
       
    }
        
    override func animate(for state: PlayerState) {
        // TODO: MAYBE animate KI's 
    }
    
    override func respawn(){
        self.run(SKAction.move(to: self.respawnPosition, duration: 1)){
            self.state = .running
        }
    }
}
