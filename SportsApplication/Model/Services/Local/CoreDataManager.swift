//
//  CoreDataManager.swift
//  SportsApplication
//
//  Created by Mahmoud  Raafat  on 09/05/2026.
//
import CoreData
import UIKit

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() {}
    
    private lazy var managedContext: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("error")
        }
        return appDelegate.persistentContainer.viewContext
    }()
    func addToFavourites(league: League) {
        guard !isFavourite(leagueId: league.id) else { return }
        
        let entity = NSEntityDescription.entity(forEntityName: "FavouriteLeague", in: managedContext)!
        let leagueObject = NSManagedObject(entity: entity, insertInto: managedContext)
        
        leagueObject.setValue(league.id, forKey: "leagueId")
        leagueObject.setValue(league.leagueName, forKey: "leagueName")
        leagueObject.setValue(league.countryName, forKey: "countryName")
        leagueObject.setValue(league.leagueLogo, forKey: "leagueLogo")
        leagueObject.setValue(league.countryLogo, forKey: "countryLogo")
        leagueObject.setValue(league.sportType, forKey: "sportType")
        
        do {
            try managedContext.save()
            print("League saved")
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func removeFromFavourites(leagueId: Int) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavouriteLeague")
        fetchRequest.predicate = NSPredicate(format: "leagueId == %d", leagueId)
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            results.forEach { managedContext.delete($0) }
            try managedContext.save()
            print("League removed ")
        } catch let error  {
            print(error.localizedDescription)
        }
    }
    
    func getAllFavourites() -> [String: [League]] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavouriteLeague")
        
        do {
            let results = try managedContext.fetch(fetchRequest)
                        let leagues = results.map { object in
                League(
                    id: object.value(forKey: "leagueId") as? Int ?? 0,
                    leagueName: object.value(forKey: "leagueName") as? String,
                    leagueLogo: object.value(forKey: "leagueLogo") as? String,
                    countryName: object.value(forKey: "countryName") as? String,
                    countryLogo: object.value(forKey: "countryLogo") as? String,
                    sportType: object.value(forKey: "sportType") as? String,
                    isFav: true
                )
            }
            
        return Dictionary(grouping: leagues) { $0.sportType ?? "Other" }
            
        } catch {
            print(error.localizedDescription)
            return [:]
        }
    }
    
    func isFavourite(leagueId: Int) -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavouriteLeague")
        fetchRequest.predicate = NSPredicate(format: "leagueId == %d", leagueId)
        
        do {
            return try managedContext.count(for: fetchRequest) > 0
        } catch {
            return false
        }
    }
}
