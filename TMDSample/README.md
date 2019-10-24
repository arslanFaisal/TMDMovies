# TMDSample
This app is developed to demonstrate my coding skills. It Displays movies data fetched from themoviedb.org API. It shows a list of popular movies and allows user to filter the movie list based on release date  and genere. User can also view the movie detail page.
### Features
- View List of Popular movies showing backdrop poster, title and rating.
- User is able to Endlessly scroll the movies (1000 pages of the api data). 
- View Details of a movie in by navigating to detail page (Backdrop or poster image,title,rating,description and release date)

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and dtebugging purposes.

### Prerequisites

You would need a macbook with XCode 11.x installed. 

### Installing

- To be able to install the build on the iPhone you will be needing Apple Developer provisioning and certifcate. You can create your Apple developer account [here](https://developer.apple.com/).
- You can create build on iOS 13.x or later simulator provided with the XCode 11.x or later.
- To run the project Navigate to the *TMDSample* folder on your machine where you cloned it. And open the project using *TMDSample.xcodeproj* file.

## User Guide to use the app
- On Launch if app is connected to the internet it automatically fetches list of 20 movies.
- As one scrolls to the bottom of the list app automatically fetches new page containing a list of next 20 movies and append those to the existing list.
- Tapping the Filter button shows a Date Picker, which allows the user to filter movies based on release date (exact date match).
- Date filter is applied on Done Tap and already fetched movies are filtered locally and a list of movies matching the chosen date are shown. If there are no movies with release date matching the chosen date list will be empty.
- Tapping the genre button open ups the Genre picker which shows a list of Genre's and an option of **All** if the user wants to see all genres.
- If user selects a particular genre, previously fteched list of movies are removed and a new list of movies matching that particular genre are fetched.
- Tapping on a Movie from the list opens up a detail page.
- Detail Page supports different layout for portrait and landscape orientation for better readability.

## Technical Details

### ThirdParty
- No Third Party library is used and everything is build using native iOS components.

### App Architecture
- MVVM Architecture is used in the app.
- Network layer is based on a protocol oriented design.

### Code Structure
Code has mainly three Groups
- Networking group contains all the files related to network layer. It contains sub groups of Reachability,NetworkHandler,NetworkRouting,HTTPHandlers,EndPoints,Services.
- Source group contains the modules with their respetive view or view controllers and view models. Source group contains further subgroups named MovieList, MovieDetail and GenrePickerView.
- Models group contains all the models being used in the app.


## Built With
- XCode 11.1
- Tested on iPhone 8. (iOS 13.1.3)

## Authors

- **Arslan Faisal** - (https://github.com/arslanFaisal)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details




