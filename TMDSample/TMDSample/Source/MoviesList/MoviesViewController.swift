//
//  ViewController.swift
//  TMDSample
//
//  Created by Arslan Faisal on 22/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var pickerView: UIView!
    
    var genrePickerView : GenrePickerView?
    var viewModel       = MoviesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        setupDatePicker()
        setupGenrePicker()
    }
}

//MARK: Init View Model
extension MoviesViewController {
    func initViewModel() {
        
        viewModel.dataFetched = { [weak self] in
            DispatchQueue.main.async { [weak self] in
                self?.moviesTableView.reloadData()
            }
        }
        
        viewModel.dataFetchFailed = { [weak self] error in
            DispatchQueue.main.async { [weak self] in
                self?.showAlertView(title: "Error", message: error)
            }
        }
        
        viewModel.removeDateFilter = { [weak self] text in
            self?.navigationItem.rightBarButtonItem?.title = text
            self?.datePicker.date = Date()
            self?.setupPickerView(hide: true)
        }
        
        viewModel.applyDateFilter = { [weak self] text in
            DispatchQueue.main.async { [weak self] in
                self?.navigationItem.rightBarButtonItem?.title = text
                self?.setupPickerView(hide: false)
                self?.showDateFilter()
            }
        }
        
        viewModel.genreFetched = { [weak self] in
            DispatchQueue.main.async { [weak self] in
                self?.genrePickerView?.setupView(list: self?.viewModel.getGenresList() ?? [])
            }
        }
        
        viewModel.fetchData()
    }
}

//MARK: IBACtion
extension MoviesViewController {
    
    @IBAction func genreFilterTapped(_ sender: Any) {
        viewModel.genreFilterButtonTapped()
        showGenreFilter()
    }
    
    @IBAction func dateFilterButtonTapped(_ sender: Any) {
        viewModel.dateFilterButtonTapped()
    }
    
    @IBAction func pickerDoneTapped(_ sender: Any) {
        viewModel.doneButtonTapped(genre: genrePickerView?.getSelectedGenre())
        setupPickerView(hide: true)
    }
}

//MARK: Setup Bottom Picker Views
extension MoviesViewController {
    
    func setupPickerView(hide: Bool) {
        bottomView.isHidden = hide
    }
    
    func setupDatePicker() {
        setupPickerView(hide: true)
        datePicker.datePickerMode   = .date
        datePicker.maximumDate      = Date()
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
    }
    
    func setupGenrePicker() {
        setupPickerView(hide: true)
        guard let picker = UINib(nibName: "GenrePickerView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as? GenrePickerView else { return }
        genrePickerView = picker
        genrePickerView?.frame = pickerView.bounds
        if let genrePickerView = genrePickerView {
            pickerView.addSubview(genrePickerView)
        }
    }
    func showGenreFilter() {
        setupPickerView(hide: false)
        genrePickerView?.isHidden = false
        datePicker.isHidden = true
    }
    
    func showDateFilter() {
        setupPickerView(hide: false)
        genrePickerView?.isHidden = true
        datePicker.isHidden = false
    }
    
    @objc func dateChanged(_ sender: UIDatePicker?) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none

        if let date = sender?.date {
            viewModel.filterData(with: date)
        }
    }
}



//MARK:- UITableView delegate and Data source methods
extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getNumberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.movieCellIdentifier, for: indexPath) as? MovieCell else { return UITableViewCell() }
        if let movieModel = viewModel.getMovie(atIndex: indexPath.section) {
            cell.setupCell(movie: movieModel)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //selectedIndex = indexPath.section
        performSegue(withIdentifier: Segues.movieListToMovieDetailSegue, sender: indexPath.section)
    }
}

//MARK: Segue Methods
extension MoviesViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == Segues.movieListToMovieDetailSegue {
            if let destinationVC = segue.destination as? MovieDetailViewController, let selectedIndex = sender as? Int {
                destinationVC.movieDetail = viewModel.getMovie(atIndex: selectedIndex)
            }
        }
        
    }
}

//MARK: Helper Methods
extension MoviesViewController {
    func showAlertView(title: String,message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

