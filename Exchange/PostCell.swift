import UIKit

class PostCell: BaseCell {
    
    var post: Post? {
        didSet {
            print(post?.imageUrl ?? "")
            
            guard let imageUrl = post?.imageUrl else { return }
            guard let item = post?.item else { return }
            guard let itemDes = post?.itemDes else { return }
            
            guard let url = URL(string: imageUrl) else { return }
            
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                if let err = err {
                    print("Failed to fetch post image:", err)
                    return
                }
                
                guard let imageData = data else { return }
                
                let photoImage = UIImage(data: imageData)
                
                DispatchQueue.main.async {
                    self.photoImageView.image = photoImage
                    self.item.text = item
                    self.itemDes.text = itemDes
                    
                }
                
            }.resume()
            
        }
    }
    
    let photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .systemGray
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    var item: UILabel = {
        let label = UILabel()
        label.text = "Masks"
        label.textColor = UIColor.rgb(red: 85, green: 72, blue: 135)
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    var itemDes : UILabel = {
        let label = UILabel()
        label.text = "Healthcare Partner"
        label.textColor = UIColor.rgb(red: 85, green: 72, blue: 135)
        label.font = label.font.withSize(15)
        return label
    }()
    
    let stack : UIStackView = {
        let sv = UIStackView()
        sv.alignment = .center
        sv.distribution = .fill
        return sv
    }()
    
    override func setupViews() {
        super.setupViews()
        self.addSubview(photoImageView)
        
        self.addSubview(itemDes)
        self.addSubview(item)
        self.addSubview(stack)
        self.addSubview(photoImageView)
        stack.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: self.frame.height - 10)
        stack.addArrangedSubview(photoImageView)
        let sv2 = UIStackView()
        photoImageView.widthAnchor.constraint(equalToConstant:70).isActive = true
        photoImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        sv2.alignment = .fill
        sv2.distribution = .fill
        sv2.axis = .vertical
        sv2.addArrangedSubview(item)
        sv2.addArrangedSubview(itemDes)
        stack.addArrangedSubview(sv2)
        stack.spacing = 20
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 15
        self.contentView.layer.cornerRadius = 15
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true

        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
}


