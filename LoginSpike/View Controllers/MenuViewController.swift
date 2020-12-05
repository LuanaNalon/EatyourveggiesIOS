//
//  MenuViewController.swift
//  LoginSpike
//
//  Created by Luana Nalon on 05/12/2020.
//

import UIKit

class MenuViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
               if(item.tag == 1) {
           //your code for tab item 1
        }
        else if(item.tag == 2) {
           //your code for tab item 2
        }
            }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
