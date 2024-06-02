//
//  ViewController.swift
//  segundoDesafioTabBar
//
//  Created by Jefferson Alves on 06/05/24.
//

import UIKit

class UploadPhotos: UIViewController {

    @IBOutlet weak var photosImageView: UIImageView!
    
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    
    let imagePicker:  UIImagePickerController = UIImagePickerController()
    
    var data: [Profile] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        configElements()
        configImagePicker()
        configTextField()
    }
    
    func configImagePicker(){
        imagePicker.delegate = self
    }
    
    func configTableView (){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.nib(), forCellReuseIdentifier: CustomTableViewCell.identifier)
    }
    
    func configTextField(){
        nameTextField.delegate = self
    }
    
    
    func configElements(){
        
        
        // config image e deixando imagem redonda
        photosImageView.clipsToBounds = true
        photosImageView.layer.cornerRadius = photosImageView.frame.height / 2
        photosImageView.image = UIImage(systemName: "person.circle.fill")
        photosImageView.backgroundColor = .black
        
        
        //config demais elementos
        view.backgroundColor = .lightGray
        uploadButton.setTitle("Upload Fotos", for: .normal)
        addButton.setTitle("Adicionar", for: .normal)
        nameLabel.text = "Legenda"
        nameTextField.placeholder = "Digite legenda de sua foto:"
        tableView.backgroundColor = .white
        
    }
    
    @IBAction func upPhotosButton(_ sender: Any) {
        
        let alertControllers: UIAlertController = UIAlertController(title: "Escollha umas das opcões abaixo: ", message: nil, preferredStyle: .actionSheet)
        
        let camera: UIAlertAction = UIAlertAction(title: "Câmera", style: .default) { (action) in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true)
        }
        
        let library: UIAlertAction = UIAlertAction(title: "Biblioteca", style: .default){ (action) in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true)
            
        }
        
        let cancel: UIAlertAction = UIAlertAction(title: "Cancelar", style: .cancel)
        
        alertControllers.addAction(camera)
        alertControllers.addAction(library)
        alertControllers.addAction(cancel)
        
        
        present(alertControllers, animated: true)
        imagePicker.allowsEditing = false
        
        
        
    }
    
    @IBAction func adicionarButton(_ sender: Any) {
        
        data.append(Profile(name: nameTextField.text ?? "", image: photosImageView.image ?? UIImage()))
        
        nameTextField.text = ""
        configElements()
        tableView.reloadData()
        
    }
    
    func validateTextField(){
        if nameTextField.text == ""{
            addButton.isEnabled = false
        }else {
            addButton.isEnabled = true
            
        }
    }
    
}

extension UploadPhotos: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell
        
        cell?.setup(data: data[indexPath.row])
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

}

extension UploadPhotos:  UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.photosImageView.image = image
        }
        
        picker.dismiss(animated: true)
    }
}

extension UploadPhotos: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.blue.cgColor
        textField.layer.borderWidth = 2
        self.validateTextField()
        
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.red.cgColor
        textField.layer.borderWidth = 2
        self.validateTextField()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
}

