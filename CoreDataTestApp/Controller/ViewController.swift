//
//  ViewController.swift
//  CoreDataTestApp
//
//  Created by Brotecs on 13/1/21.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var items: [Person]?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        fetchPeople()

    }
    func relationshipDemo(){
        //create a family
        let family = Family(context: context)
        family.name = "Adam's Family"
        //create a person
        let person = Person(context: context)
        person.name = "Alan"
        person.gender = "Male"
        person.age = 12
        
        //Building relationship
        //option 1:
        person.family = family
        //option 2:
        family.addToPeople(person)
        
        //save context
    }
    func fetchPeople(){
        //Fetch data from the coreData in the tableView
        
        do{
            //import CoreData before using NSFetchRequest
            let request = Person.fetchRequest() as NSFetchRequest<Person>
            //Filter data : fetching only the names containing 'Ted'
//            let pred = NSPredicate(format: "name CONTAINS %@","Ted")
//            request.predicate = pred
            
            //sorting: in ascending order
            let sort = NSSortDescriptor(key: "name", ascending: true)
            request.sortDescriptors = [sort] // since there may happens to be many sorting constraints that is why array is returned
            self.items = try context.fetch(request)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch{
            print(error)
        }
    }
    
    @IBAction func addItemButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Add", message: "Name", preferredStyle: .alert)
        alert.addTextField()
        let submitAction = UIAlertAction(title: "Submit", style: .default) { (action) in
            let textField = alert.textFields![0]
            let newPerson = Person(context: self.context)
            newPerson.name = textField.text
            newPerson.age = 20
            newPerson.gender = "Male"
            
            //save data
            do{
                try self.context.save()
            } catch{
                print("Error during saving data : \(error)")
            }
            
            //re-fetch data from coredata
            self.fetchPeople()
        }
        alert.addAction(submitAction)
        present(alert, animated: true, completion: nil)
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        let person = items![indexPath.row]
        cell.itemLabel.text = person.name
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let personSelected =  self.items![indexPath.row]
        let alert = UIAlertController(title: "Edit", message: "Edit information of this person?", preferredStyle: .alert)
        alert.addTextField()
        let submitAction = UIAlertAction(title: "Update", style: .default) { (action) in
            let textField = alert.textFields![0]
            textField.text = personSelected.name
            //update the person name
            personSelected.name = textField.text
            
            //save the data
            do{
                try self.context.save()
            }catch {
                print("Error in updating data")
            }
             //re-fetch data from coredata
            self.fetchPeople()
        }
        alert.addAction(submitAction)
        present(alert, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            
            //the person to be removed
            let personToBeRemoved = self.items![indexPath.row]
            //remove the person
             self.context.delete(personToBeRemoved)
            //save the context
            do{
                try self.context.save()
            } catch{
                print("error in deleting person")
            }
            //re-fetch data from coredata
            self.fetchPeople()
              
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    
}

