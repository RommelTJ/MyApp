//
//  ViewController.swift
//  MyApp
//
//  Created by Rommel Rico on 12/19/16.
//  Copyright © 2016 Rommel Rico. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    // MARK: Core Data Context property
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSample()
        setSample()
        getSample()
        resetSample()
        getSample()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Get data from the attribute
    func getSample() {
        let request: NSFetchRequest = SampleEntity.fetchRequest()
        request.resultType = NSFetchRequestResultType.dictionaryResultType
        do {
            let searchResults = try context.fetch(request as! NSFetchRequest<NSFetchRequestResult>) as! [NSDictionary]
            let searchResultsArray = searchResults.map { $0["sampleAttribute"] as! String }
            print("searchResultsArray", searchResultsArray)
        } catch {
            print("Error with request: \(error)")
        }
    }
    
    // Save to the attribute
    func setSample() {
        let saveSample = SampleEntity(context: context)
        saveSample.sampleAttribute = "Save a new string."
        do {
            try context.save()
        } catch {
            print("Error with save: \(error)")
        }
    }
    
    // clear the attribute
    func resetSample() {
        let clearSample: NSFetchRequest = SampleEntity.fetchRequest()
        let deleteResults = NSBatchDeleteRequest(fetchRequest: clearSample as! NSFetchRequest<NSFetchRequestResult>)
        do {
            try context.execute(deleteResults)
            try context.save()
        } catch {
            print("Error with save: \(error)")
        }
    }

}

