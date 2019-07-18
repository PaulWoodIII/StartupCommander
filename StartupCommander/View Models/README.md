#  Presenters

Presenters are objects that manipulate the App's data on the Views behalf, and provide clear View Models to the View for rendering. 

Presenters are reference types (classes) that conform to BindableObject which allows them to inform Views of changes to state that should be displayed to the user. 

Presenters depend on Services to provide them with state to be rendered to the View that are Reference types, presenters will do the heavy lifting of transforming these classes to ViewModels which are structs. 

A ViewModel is the means the Presenter provides infromation to a View, it can be defined in the same source file as the presenter if it is compact. 

Presenters should use Publishers as a means to handle the change in their state. This allos them to leverage a declarative method to discribe when their view models have been updated. Subjects used to create these publishers should be hidden from their public API to prevent Views from changing state directly, casuing a loop. Data must flow in a unidirectional way. 

Views communicate the user's intent to the Presenter through functions.

Examples:

func onAppear()
func didAdd(_ vm: ViewModelType)
func didUpdate(_ vm: ViewModelType)
func didDelete(_ vm: ViewModelType)

### Other Naming options for Presenters

ViewModel in the MVVM method, where a view model does some business logic as well as provides the data to render
Component (seems to be a favored word is you merge My services and Presenters into a common class of objects)
Controller - it is a middleman of some sort
