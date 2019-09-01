//
//  ViewController.swift
//  ProyectoLectorRSS-A
//
//  Created by Adolfo De la Rosa on 29/08/2019.
//  Copyright © 2019 ADP. All rights reserved.
//

import UIKit

struct Post: Codable {
    let id : Int
    let date : String
    let link : String
    let title : Title
    let content : Content
    let excerpt : Excerpt
    let jetpack_featured_media_url : String
}

struct Title: Codable {
    let rendered : String
}

struct Content: Codable {
    let rendered : String
}

struct Excerpt: Codable {
    let rendered : String
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tabla: UITableView!
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getJson()
        // Do any additional setup after loading the view.
    }
    
    func getJson(){
        guard let urlDatos = URL(string: "https://applecoding.com/wp-json/wp/v2/posts") else { return }
        let url = URLRequest(url: urlDatos)
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let response = response {
                print(response)
            }
            do{
                self.posts = try JSONDecoder().decode([Post].self, from: data!)
                DispatchQueue.main.async {
                    self.tabla.reloadData()
                }
            }catch let error as NSError {
                print("No carga el JSON ", error.localizedDescription)
            }
            }.resume()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabla.dequeueReusableCell(withIdentifier: "zeldaPost", for: indexPath)
        let post = posts[indexPath.row]
        cell.textLabel?.text = String(post.id) + " - " + post.title.rendered + " - " + post.date + " - " + post.link
        //cell.detailTextLabel?.text = "( " + post.title.rendered + " -  " +  post.jetpack_featured_media_url  + " )"
        
        return cell
    }


}

