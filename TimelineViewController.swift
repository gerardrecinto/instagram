//
//  TimelineViewController.swift
//  instagram
//
//  Created by Gerard Recinto on 3/13/17.
//  Copyright © 2017 Gerard Recinto. All rights reserved.
//

import UIKit
import Parse
class TimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  @IBOutlet weak var tableView: UITableView!
  var instaFeed: [PFObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
      self.tableView.dataSource = self
      self.tableView.delegate = self
      tableView.rowHeight = UITableViewAutomaticDimension
      tableView.estimatedRowHeight = 180

        // Do any additional setup after loading the view.
    }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(true)
    let query = PFQuery(className: "Post")
    query.order(byDescending: "createdAt")
    query.limit = 20
    query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
      if let posts = posts{
        self.instaFeed = posts
        self.tableView.reloadData()
      } else {
        print(error?.localizedDescription)
      }
    }
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return instaFeed.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! InstaPostCell
    let post = instaFeed[indexPath.row]
    let photo = post["media"] as! PFFile
    photo.getDataInBackground { (
      data: Data?,
      error: Error?) in
      if let data = data {
        cell.photoImageView.image = UIImage(data: data)
      }
    }
    cell.capLabel.text = post["caption"] as! String?
    return cell
  }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
