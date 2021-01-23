//
//  CourseTableViewController.swift
//  CourseView
//
//  Created by Bryan Nelson on 1/22/21.
//

import UIKit

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
        let cell = tableView.dequeueReusableCell(withIdentifier: "courseCell", for: indexPath)

        let course = courses[indexPath.row]
        
        //cell.textLabel?.text = course.title

        return cell
    }

    @IBAction func reloadTapped(_ sender: Any) {
        getCourses()
    }
}
