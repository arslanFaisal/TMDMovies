//
//  MoviesViewModel.swift
//  TMDSample
//
//  Created by Arslan Faisal on 22/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import Foundation

class MoviesViewModel {
    
    enum SelectedFilter {
        case none
        case genre
        case date
    }
    
    private var trendingService         = TrendingMoviesService(NetworkHandler())
    private var genreService            = GenreService(NetworkHandler())
    private var confingurationService   = ConfigurationService(NetworkHandler())
    
    private var page                    = 1
    private var selectedGenre           : Genre?     = nil
    private var selecterFilter          : SelectedFilter = .none
    private var moviesList              = [Movie]()
    private var filteredMoviesList      = [Movie]()
    private var genres                  = [Genre]()
    
    //MARK: Closures
    var dataFetched                     : (()->())?
    var dataFetchFailed                 : ((String)->())?
    var applyDateFilter                 : ((String)->())?
    var removeDateFilter                : ((String)->())?
    var genreFetched                    : (()->())?
    var configurationFetched            : (()->())?

    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.connectivityChanged(_:)), name: NSNotification.Name(rawValue: NotificationNames.networkReachability), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    @objc func connectivityChanged(_ notification:Notification) {
//        if let connectivity = notification.object as? Bool, connectivity, moviesList.isEmpty {
//            fetchMoviesData()
//        }
    }
}
//MARK: View Service Methods
extension MoviesViewModel {
    func getGenresList() -> [Genre] {
        return genres
    }
    func getNumberOfRows() -> Int {
        switch selecterFilter {
        case .date:
            return filteredMoviesList.count
        default:
            return moviesList.count
        }
    }
    func getMovie(atIndex index: Int) -> Movie? {
        switch selecterFilter {
        case .date:
            guard index >= 0 && index < filteredMoviesList.count else { return nil }
            return filteredMoviesList[index]
        default:
            if index >= moviesList.count - 3 && page <= 1000 {
                fetchNextPage()
            }
            guard index >= 0 && index < moviesList.count else { return nil }
            return moviesList[index]
        }
    }
    func dateFilterButtonTapped() {
        if selecterFilter == .date {
            selecterFilter = .none
        } else {
            selecterFilter = .date
        }
        
        switch selecterFilter {
        case .date:
            applyDateFilter?("Remove Filter")
            filterData(with: Date().stripTime())
        default:
            removeDateFilter?("Filter")
            dataFetched?()
        }
    }
    
    func genreFilterButtonTapped() {
        removeDateFilter?("Filter")
        selecterFilter = .genre
    }
    
    func filterData(with date: Date) {
        filteredMoviesList = moviesList.filter { $0.releaseDate == date }
        dataFetched?()
    }
}
//MARK: Network Fetch methods
extension MoviesViewModel {
    func fetchData() {
        fetchGenreData()
        fetchMoviesData()
    }
    
    func doneButtonTapped(genre: Genre?) {
        switch selecterFilter {
        case .genre:
            FetchMoviesForGenre(with: genre)
        default:
            break
        }
    }
    
    func FetchMoviesForGenre(with genre: Genre?) {
        moviesList.removeAll()
        page = 1
        selectedGenre = genre
        fetchMoviesData()
    }
    private func fetchNextPage() {
        page += 1
        fetchMoviesData()
    }
    private func fetchGenreData() {
        genreService.fetchGenre { [weak self] (genres, errorString) in
            if let genres = genres, errorString == nil {
                self?.genres = genres
                self?.genreFetched?()
            }
        }
    }
    private func fetchMoviesData() {
        trendingService.fetchTrendingMovies(page: page, genre: selectedGenre?.id) { [weak self] (moviesResponse, errorString) in
            if let errorString = errorString {
                self?.dataFetchFailed?(errorString)
            } else if let moviesResponse = moviesResponse {
                if let movies = moviesResponse.movies {
                    self?.moviesList.append(contentsOf: movies)
                    self?.dataFetched?()
                }
                
            }
        }
    }
    private func fetchConfigurationData() {
        confingurationService.fetchConfiguration { [weak self] (configuration, errorString) in
            if let _ = configuration, errorString == nil {
                self?.configurationFetched?()
            }
        }
    }
}
