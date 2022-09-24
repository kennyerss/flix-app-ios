import UIKit
import AlamofireImage

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var tableView: UITableView!
    
    var moviesArray: [[String:Any?]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 150
        tableView.dataSource = self
        tableView.delegate = self
        getApiData()
        
    }

    func getApiData() {
        
        API.getMovies() { (movies) in
            guard let movies = movies else {
                return
            }
            self.moviesArray = movies
            self.tableView.reloadData()
        }
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        let movie = moviesArray[indexPath.row]
        let title = movie["title"] as! String
        let synopsis = movie["overview"] as! String
        
        cell.titleLabel!.text = title
        cell.synopsisLabel!.text = synopsis
        
        // Get the poster images base url + size
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        
        let posterUrl = URL(string: baseUrl + posterPath)
        
        cell.posterImageView.af.setImage(withURL: posterUrl!)
        return cell
    }
    
    // Navigation: Show controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Find selected movie
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let movie = moviesArray[indexPath.row]
        
        // Pass selected movie to MovieDetailsViewController
        let detailViewsController = segue.destination as! MovieDetailsViewController
        
        detailViewsController.movie = movie
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
}

