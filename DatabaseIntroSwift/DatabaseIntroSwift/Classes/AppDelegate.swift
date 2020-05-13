
import UIKit
import SQLite3

// step 0 - see file HowToCreateSQLiteDB.txt on how to create your db file.
// step 0b - import db file into project
// step 0c - add sqlite libraries to project in project settings
// step 1 - create storyboard as outlined
// step 2 - create view controllers, TableViewController & PickerViewController
// step 3 - create custom class Data - move on to Data.h

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // step 5 - create variables for database below
    var window: UIWindow?
    var databaseName : String? = "MyDatabase.db"
    var databasePath : String?
    var people : [DataC] = []

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // step 5a - setup the path for where db file will be accessed from
        // want to use ~/Documents folder on phone.
        
        // this method creates an array of directories under ~/Documents
        let documentPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
       
        // ~/Documents is always at index 0
        let documentsDir = documentPaths[0]
        
        // append filename such that path is ~/Documents/MyDatabase.db
        databasePath = documentsDir.appending("/" + databaseName!)
       
        // step 6
        // move onto creating method checkAndCreateDatabase
        checkAndCreateDatabase()
        
        // step 7
        // move on to creating method readDataFromDatabase
        readDataFromDatabase()
        
        return true
    }
    func checkAndCreateDatabase()
    {

    // step 6a create method as follows
    
    // first step is to see if the file already exists at ~/Documents/MyDatabase.db
    // if it exists, do nothing and return
        var success = false
        let fileManager = FileManager.default
        
        success = fileManager.fileExists(atPath: databasePath!)
    
        if success
        {
            return
        }
    
    // if it doesn't (meaning its a first time load) find location of
    // MyDatabase.db in app file and save the path to it
        let databasePathFromApp = Bundle.main.resourcePath?.appending("/" + databaseName!)
        
    
    // copy file MyDatabase.db from app file into phone at ~/Documents/MyDatabase.db
        try? fileManager.copyItem(atPath: databasePathFromApp!, toPath: databasePath!)
    
    // return to didFinishLaunching (don't forget to call this method there)
    return;
    }
  
    func readDataFromDatabase()
    {
    // now we will retrieve data from database
    // step 7a - empty people array
    people.removeAll()
    
    // step 7b - define sqlite3 object to interact with db
        var db: OpaquePointer? = nil
        
        // step 7c - open connection to db file - this is C code
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
            print("Successfully opened connection to database at \(self.databasePath)")
            
            // step 7d - setup query - entries is the table name you created in step 0
            var queryStatement: OpaquePointer? = nil
            var queryStatementString : String = "select * from entries"
            
            // step 7e - setup object that will handle data transfer
            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
                
                // step 7f - loop through row by row to extract dat
                while( sqlite3_step(queryStatement) == SQLITE_ROW ) {
                
                    // step 7g - extract columns data, convert from char* to NSString
                    // col 0 - id, col 1 = name, col 2 = email, col 3 = food
                    
                    let id: Int = Int(sqlite3_column_int(queryStatement, 0))
                    let cname = sqlite3_column_text(queryStatement, 1)
                    let age: Int = Int(sqlite3_column_int(queryStatement, 2))
                    let cAvatar = sqlite3_column_text(queryStatement, 3)

                    
                    let name = String(cString: cname!)
                    let avatar = String(cString: cAvatar!)
                    let data = DataC.init(id: Int32(id), name: name, age:Int32(age), avatar: avatar)
                    people.append(data!)
                    
                    print("Query Result:")
                    print("\(id) | \(name) | \(age) | \(avatar)")
                    
                }
                // step 7i - clean up
                
                sqlite3_finalize(queryStatement)
            } else {
                print("SELECT statement could not be prepared")
            }
            
            
            // step 7j - close connection
            // move on to ViewController.swift
            sqlite3_close(db);
        } else {
            print("Unable to open database.")
        }
    
    }

    // step 16 - add method to insert new row into database
    // this method will follow a similar approach to readDataFromDatabase
    // but to insert a new row
    func insertIntoDatabase(person : DataC) -> Bool
    {
        // step 16b - define sqlite3 object to interact with db
        var db: OpaquePointer? = nil
        var returnCode : Bool = true
        // step 16c - open connection to db file - this is C code
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
            print("Successfully opened connection to database at \(self.databasePath)")
            
            // step 16d - setup query - entries is the table name you created in step 0
            var insertStatement: OpaquePointer? = nil
            var insertStatementString : String = "insert into entries values(NULL, ?, ?, ?)"
            
            // step 16e - setup object that will handle data transfer
            if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
               
           
                // step 16f attach items from data object to query
                
                // **Note need to cast as NSString so you can convert to utf8String.  Not doing this will result in fourth column overwriting second and third column
                let nameStr = person.name! as NSString
                let age = "\(person.age)" as! NSString
                let avatarStr = person.avatar! as NSString
                
                sqlite3_bind_text(insertStatement, 1, nameStr.utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 2, age.utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 3, avatarStr.utf8String, -1, nil)

                
                // step 16g - execute query
                if sqlite3_step(insertStatement) == SQLITE_DONE {
                    let rowID = sqlite3_last_insert_rowid(db)
                    print("Successfully inserted row. \(rowID)")
                } else {
                    print("Could not insert row.")
                    returnCode = false
                }
                // step 16h - clean up
                sqlite3_finalize(insertStatement)
            } else {
                print("INSERT statement could not be prepared.")
                returnCode = false
            }
            
            
            // step 16i - close db connection
            // move on to ViewController.swift
            sqlite3_close(db);
            
        } else {
            print("Unable to open database.")
            returnCode = false
        }
        return returnCode
    }
    // step 16 - add method to insert new row into database
    // this method will follow a similar approach to readDataFromDatabase
    // but to insert a new row
    func updateDB(person : DataC) -> Bool {
        var db: OpaquePointer? = nil
        var returnCode : Bool = true
        //person.age = 100 ; person.avatar = "3" ;person.name = "Jackie"
        // step 16c - open connection to db file - this is C code
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
            var updateStatement: OpaquePointer?
            let updateStatementString = "update entries set Name = '\(person.name!)',Age = \(person.age),Avatar = '\(person.avatar!)' where ID = \(person.id)"
            if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) ==
                SQLITE_OK {
                if sqlite3_step(updateStatement) == SQLITE_DONE {
                    print("\nSuccessfully updated row.")
                    return true
                } else {
                    print("\nCould not update row.")
                    return false
                }
            } else {
                print("\nUPDATE statement is not prepared")
                return false
            }
            sqlite3_finalize(updateStatement)
            sqlite3_close(db);
        }
        else
        {
            return false
        }
    }
    func deleteFromDB(person : DataC) -> Bool {
        var db: OpaquePointer? = nil
        var returnCode : Bool = true
        // step 16c - open connection to db file - this is C code
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
            var deleteStatement: OpaquePointer?
            let deleteStatementString = "delete from entries where ID = \(person.id)"
            if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) ==
                SQLITE_OK {
                if sqlite3_step(deleteStatement) == SQLITE_DONE {
                    print("\nSuccessfully deleted row.")
                    return true
                } else {
                    print("\nCould not delete row.")
                    return false
                }
            } else {
                print("\nDelete statement is not prepared")
                return false
            }
            sqlite3_finalize(deleteStatement)
            sqlite3_close(db);
        }
        else
        {
            return false
        }
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

