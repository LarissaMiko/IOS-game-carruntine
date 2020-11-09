
import Foundation
import CoreData
import SpriteKit
import UIKit


class CoreDataService {
    // needed to access CoreData database
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate;
    static let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static func getPlayer() -> PlayerEntity? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PlayerEntity")

        // Helpers
        var results = [PlayerEntity]()
        
        do {
            // Execute Fetch Request
         let records = try managedObjectContext.fetch(fetchRequest)

            if let records = records as? [PlayerEntity] {
                results = records
            }

        } catch {
            // ignore
        }
        
        return results.first
    }
    
    static func saveContext() {
        appDelegate.saveContext()
    }
    
    static func deleteAllEntries() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "PlayerEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try managedObjectContext.execute(deleteRequest)
        } catch let error as NSError {
            // ignore, should not happen
        }
    }
}
