//
//  Model.swift
//  ProyectoLectorRSS-A
//
//  Created by Adolfo De la Rosa on 01/09/2019.
//  Copyright © 2019 ADP. All rights reserved.
//

import UIKit
/*
struct Posts: Codable {
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

func loadPosts() -> [Posts] {
    guard let urlDatos = URL(string: "https://applecoding.com/wp-json/wp/v2/posts") else { return[] }
    let url = URLRequest(url: urlDatos)
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let response = response {
            print(response)
        }
        do{
            let datos = try Data(contentsOf: urlDatos)
            let posts = try JSONDecoder().decode([Posts].self, from: datos)
            print("POSTS ENCONTRADOS")
            print(posts)
            DispatchQueue.main.async {
                //self.tabla.reloadData()
            }
        }catch let error as NSError {
            print("No carga el JSON ", error.localizedDescription)
        }
        }.resume()
    return []
}
*/
