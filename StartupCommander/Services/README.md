#  Services


Services to me as a part of my design pattern are Objects that handle data manipulation and often rely on one another's existance. They mostly deal with the state of the application. Their inputs are facades on 3rd party frameworks and system frameworks. 

Services can and should be Unit Tested, the only drawbacks are 3rd Party Frameworks that are dependecies that are poorly archetected for Unit Test.

Services deal with Models and these models can be defined in the same source file as the service or in the same folder group of the service 

The data that services hold are often reference types, specifially they are classes not structs. This is because one reference may not to be "equal" to another but have the same identity (for example you have a record in the cache and the requested update to the record in the cache, they have the same identity but they are not equal) Read up on Combine in Practice and Swift API design for more on this.

Services are used by Presenters to request work to be done, the services Output is then rendered into a view model for the presenter to pass to a View.

Services have a 1:* relationship with Presenters, and Presenters have a 1:* relationship with Views, this is mostly because View Controllers are not needed in a SwiftUI App. Services have a *:* relationship with other service but should have a 1:1 relationship with 3rd Party Frameworks whenever possible to keep the notion of 1 source of truth. The service in this case can easily be pointed to as the source of truth for Reference type data a presenter can manipulate.

Changes to the underlying data modeled by a service should be exposed to Presenters using Publishers

Changes to the Service requested by a Presenter should be requested using a function that returns a Publisher that will give the Presenter a result asynchronously.  A service's work should be done on a background thread.  If a service's function does not require asynconous work a simple return value is also acceptable.


## Examples

CoreDataService - a service that handles the core data stack and allows for manipulation and retrival of Core Data Objects
CloudKitService - a service that handles the CloudKit framework and helps manipulate and retrive CKRecords, Presenters could use it to request new data or update data on the View's behalf. Keeps a cache of CKRecords in memory, uses the CoreDataService to cache the records. 
ImageService - Download, cache, and return Images (a wrapper over KingFisher for example)
ConnectivityService - A wrapper on the availabilty API that knows about how the phone is connected to the internet or not

### Other Naming Options if Service isn't something you like as a name
Components
Stores
DataManagers
Model
