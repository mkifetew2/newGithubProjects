//
//  StartPageViewController.swift
//  Cee-lo
//
//  Created by Mikias Kifetew on 2019-06-19.
//  Copyright © 2019 MK_corp. All rights reserved.
//

import UIKit

class StartPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let imageName = "Dice Up Interface"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        
        imageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        view.addSubview(imageView)
        
        
        //
        let imageName2 = "number of players-1"
        let image2 = UIImage(named: imageName2)
        let imageView2 = UIImageView(image: image2!)
        
        imageView2.frame = CGRect(x: 25, y: 253, width: 325, height: 160)
        imageView2.contentMode = .scaleAspectFill
        view.addSubview(imageView2)
        
        
        //
        let imageName3 = "2"
        let image3 = UIImage(named: imageName3)
        let imageView3 = UIImageView(image: image3!)
        
        imageView3.frame = CGRect(x: 10, y: 432, width: 115, height: 200)
        imageView3.contentMode = .scaleAspectFill
        view.addSubview(imageView3)
        
        
        //
        let imageName4 = "3"
        let image4 = UIImage(named: imageName4)
        let imageView4 = UIImageView(image: image4!)
        
        imageView4.frame = CGRect(x: 133, y: 425, width: 115, height: 200)
        imageView4.contentMode = .scaleAspectFill
        view.addSubview(imageView4)
        
        
        //
        let imageName5 = "4"
        let image5 = UIImage(named: imageName5)
        let imageView5 = UIImageView(image: image5!)
        
        imageView5.frame = CGRect(x: 256, y: 425, width: 115, height: 200)
        imageView5.contentMode = .scaleAspectFill
        view.addSubview(imageView5)
        
        
        
        
        

        // Do any additional setup after loading the view.
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
