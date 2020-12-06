import UIKit
import Photos
class RequestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FormDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var request = Request()
    var requestDes = [String:String]()
    
    func addTo(key: String, description: String) {
        requestDes[key] = description
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return formArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! FormCell
        cell.titleLabel.text = formArray[indexPath.row]
        cell.delegate = self
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180/3
        
    }
    
    
    
    
    
    
    var form: UITableView = {
        let tv = UITableView()
        return tv
    }()
   
    
    var categoryView: UIView = {
        let view = UIView()

        return view
    }()
    var categoryStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
           
        stackView.distribution = .fillEqually
           
        return stackView
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "What would you like to donate?"
        requestDes["name"] = "zhanhugo"
        requestDes["nameDes"] = "HealthCare Partner"
        requestDes["city"] = "Irvine"
        requestDes["state"] = "CA"
        self.view.backgroundColor = .white
        
        
        form.register(FormCell.self, forCellReuseIdentifier: "myCell")
        form.dataSource = self
        form.delegate = self
        form.separatorStyle = .singleLine
        setupView()
        
       
       
        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
            self.view.addGestureRecognizer(tapGesture)
        }

        @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
            self.view.endEditing(true)
        }
    
    var question: UILabel = {
        let label = UILabel()
        label.text = "What category?"
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    
    var urgent: UILabel = {
        let label = UILabel()
        label.text = "Are you able to pick up your item?"
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    
    
    var yesButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.layer.cornerRadius = 15
        button.setTitle("Yes", for: .normal)
        
        button.setBackgroundColor(.purple, for: .selected)
        button.setBackgroundColor(.purple, for: .highlighted)
        button.setBackgroundColor(UIColor.rgb(red: 97, green: 177, blue: 90), for: .normal)
        return button
    }()
    var noButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.layer.cornerRadius = 15
        button.setTitle("No", for: .normal)
        button.setBackgroundColor(.purple, for: .selected)
        button.setBackgroundColor(.purple, for: .highlighted)
        button.setBackgroundColor(UIColor.rgb(red: 97, green: 177, blue: 90), for: .normal)
        
        return button
    }()
    func setupView() {
        
        
        
        setupStack()
        categoryView.addSubview(question)
        categoryView.addSubview(categoryStack)
        categoryView.addSubview(urgent)
        categoryView.addSubview(yesButton)
        categoryView.addSubview(noButton)
    
        self.view.addSubview(form)
        form.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, left: self.view.leftAnchor, bottom: nil, right: self.view.rightAnchor, paddingTop: 50, paddingLeft: 20, paddingBottom: 0, paddingRight: -20, width: 0, height: 180)
        question.anchor(top: categoryView.topAnchor, left: categoryView.leftAnchor, bottom: nil, right: categoryView.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        categoryStack.anchor(top: question.bottomAnchor, left: categoryView.leftAnchor, bottom: nil, right: categoryView.rightAnchor, paddingTop: 30, paddingLeft: 30, paddingBottom: 0, paddingRight: -30, width: 0, height: 40)
        
        
        urgent.anchor(top: categoryStack.bottomAnchor, left: categoryView.leftAnchor, bottom: nil, right: categoryView.rightAnchor, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        yesButton.anchor(top: urgent.bottomAnchor, left: categoryView.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 60, paddingBottom: 0, paddingRight: 0, width: 70, height: 30)
        
        noButton.anchor(top: urgent.bottomAnchor, left: nil, bottom: nil, right: categoryView.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: -60, width: 70, height: 30)
        
        
        
        
        
        
        
        self.view.addSubview(categoryView)
        categoryView.backgroundColor = .white
        categoryView.anchor(top: form.bottomAnchor, left: self.view.leftAnchor, bottom: nil, right: self.view.rightAnchor, paddingTop: 20, paddingLeft:20, paddingBottom: 0, paddingRight: -20, width: 0, height: 250)
        self.view.addSubview(postButton)
        
        
        postButton.anchor(top: categoryView.bottomAnchor, left: self.view.leftAnchor, bottom:self.view.safeAreaLayoutGuide.bottomAnchor, right: self.view.rightAnchor, paddingTop: 100, paddingLeft: 70, paddingBottom:-20, paddingRight: -70, width: 0, height: 0)
        postButton.addTarget(self, action: #selector(createNewDonation), for: .touchUpInside)
        
        
    
    }
    
    

    
    
    
    
    
    @objc func addPhoto() {
        
        self.showAlert()
    }
    
    @objc func createNewDonation() {
        requestDes["url"] = imageurl
        for (key, value) in requestDes {
            switch key {
            case "name":
                request.name = value
            case "quantity":
                request.quantity = Int(value)!
            case "description":
                request.itemDes = value
            case "city":
                request.city = value
            case "state":
                request.state = value
            case "item":
                request.item = value
            case "nameDes":
                request.nameDes = value
            case "url":
                request.url = value
            default:
                return
            }
        }
        requestData.append(request)
        self.dismiss(animated: true, completion: nil)
        
        
    }
    
    var formArray = ["item", "quantity", "description"]
    
    var postButton : UIButton = {
        let button = UIButton()
        button.setTitle("post", for: .normal)
        button.backgroundColor = UIColor.rgb(red: 173, green: 206, blue: 116)
        button.layer.cornerRadius = 20
        return button
    }()
    
    func setupStack() {
        
        let button1 = makeButton(backgroundColor: UIColor.rgb(red: 255, green: 99, blue: 99), name: "medical", tag: 0)
        let button2 = makeButton(backgroundColor: UIColor.rgb(red: 203, green: 255, blue: 194), name: "hands", tag: 1)
        let button3 = makeButton(backgroundColor: UIColor.rgb(red: 165, green: 239, blue: 255), name: "water", tag: 2)
        let button4 = makeButton(backgroundColor: UIColor.rgb(red: 255, green: 205, blue: 241), name: "food", tag: 3)
        let button5 = makeButton(backgroundColor: UIColor.rgb(red: 253, green: 255, blue: 140), name: "shirt", tag: 4)
        categoryStack.addArrangedSubview(button1)
        categoryStack.addArrangedSubview(button2)
        
        categoryStack.addArrangedSubview(button3)
        categoryStack.addArrangedSubview(button4)
        categoryStack.addArrangedSubview(button5)
        
        
    }
    
    var categoryArray = ["medical", "hands", "water", "food", "shirt"]
    func makeButton(backgroundColor: UIColor, name:String, tag: Int) -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.backgroundColor = backgroundColor
        button.tintColor = .black
        button.tag = tag
        button.setImage(UIImage(named:name)?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.contentMode = .center
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(categorySelected(_:)), for: .touchUpInside)
        
        return button
    }
    
    
    
    @objc func categorySelected(_ sender: UIButton) {
        print(sender.tag)
    }
    
   
    private func showAlert() {

        let alert = UIAlertController(title: "Image Selection", message: "From where you want to pick this image?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    //get image from source type
    private func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {

        //Check is source type available
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {

            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }

    var imageurl: String?
    

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }


    func checkPermission() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
    
        switch photoAuthorizationStatus {
        case .authorized:
            print("Access is granted by user")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                print("status is \(newStatus)")
                if newStatus ==  PHAuthorizationStatus.authorized {
                    /* do stuff here */
                    print("success")
                }
            })
            print("It is not determined until now")
        case .restricted:
            // same same
            print("User do not have access to photo album.")
        case .denied:
            // same same
            print("User has denied the permission.")
        case .limited:
            print("User has denied the permission.")

        @unknown default:
            print("User has denied the permission.")

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






