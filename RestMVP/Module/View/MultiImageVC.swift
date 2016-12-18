//
//  MultiImageVC.swift
//  RestMVP
//
//  Created by Cyberk on 12/18/16.
//  Copyright © 2016 Cyberk. All rights reserved.
//

import UIKit
import ImagePicker
private let reuseIdentifier = "Cell"
var arrImg = [UIImage]()


class MultiImageVC: UICollectionViewController {
    var eventHandler : MultiUploadPresenter?
    override func viewDidAppear(_ animated: Bool) {
        collectionView?.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        eventHandler = MultiUploadPresenter()
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

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
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        print(arrImg.count)
        return arrImg.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectioncell", for: indexPath) as! CollectionViewCell
        
        // Configure the cell
        cell.eachImageView.image = arrImg[indexPath.row]
        return cell
    }

    @IBAction func UploadImages(_ sender: Any) {
        eventHandler?.uploadMultiImage(Data: arrImg)
        dismiss(animated: true, completion: nil)
        
    }

    @IBAction func AddImage(_ sender: Any) {
        let imagePickerController = ImagePickerController()
        imagePickerController.imageLimit = 5
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
extension MultiImageVC: ImagePickerDelegate{
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        for image in images{
            arrImg.append(image)
        }
        
        print(arrImg)
        dismiss(animated: true, completion: nil)
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        _ = navigationController?.popViewController(animated: true)
    }
}
