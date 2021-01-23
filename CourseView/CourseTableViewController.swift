//
//  CourseTableViewController.swift
//  CourseView
//
//  Created by Bryan Nelson on 1/22/21.
//

import UIKit
import Kingfisher

class CourseTableViewController: UITableViewController {
    
    var courses: [Course] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCourses()
    }
    
    func getCourses() {
        // https://zappycode.com/api/courses
        
        if let url = URL(string: "https://zappycode.com/api/courses") {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            URLSession.shared.dataTask(with: request) {(data, response, error) in
                
                if error != nil {
                    print("There was an error")
                } else if data != nil {
                    if let coursesFromAPI = try? JSONDecoder().decode([Course].self, from: data!) {
                        DispatchQueue.main.async {
                            self.courses = coursesFromAPI
                            self.tableView.reloadData()
                        }
                    }
                }
                
            }.resume()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "courseCell", for: indexPath) as? CourseTableViewCell {

            let course = courses[indexPath.row]
            
            cell.titleLabel.text = course.title
            cell.subtitleLabel.text = course.subtitle
            
            if let url = URL(string: course.imageURL) {
                cell.courseImage.kf.setImage(with: url)
            }
            
            return cell
        }
        return UITableViewCell()
    }

    @IBAction func reloadTapped(_ sender: Any) {
        getCourses()
    }
}
