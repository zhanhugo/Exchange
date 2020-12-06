import UIKit
import Firebase

class UserProfileHeader: UICollectionViewCell {
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .systemGray
        return iv
    }()
    
    var name: UILabel = {
        let label = UILabel()
        label.text = "Zhanhugo"
        label.textColor = .white
        label.font = label.font.withSize(20)
        return label
    }()
    
    
    var nameDes : UILabel = {
        let label = UILabel()
        label.text = "Healthcare Partner"
        label.textColor = .white
        label.textColor = .white
        label.font = label.font.withSize(15)
        return label
    }()

    let stack : UIStackView = {
           let sv = UIStackView()
           sv.alignment = .center
           sv.distribution = .fill
           return sv
       }()
    let donations: UILabel = {
        
        let label = UILabel()
        label.textColor = .white
        let attributedText = NSMutableAttributedString(string: "12\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
        
        attributedText.append(NSAttributedString(string: "Donations", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]))
        
        label.attributedText = attributedText
        
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let requests: UILabel = {
        
        let label = UILabel()
        label.textColor = .white
        let attributedText = NSMutableAttributedString(string: "50\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
        
        attributedText.append(NSAttributedString(string: "Fulfilled Requests", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]))
        
        label.attributedText = attributedText
        
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    
    let tracking : UIStackView = {
        let stackView = UIStackView()
        
        return stackView
    }()
    
    
    let sub : UILabel = {
        let view = UILabel()
        view.text = ""
        view.textColor = .black
        view.font = UIFont.boldSystemFont(ofSize: 20)
        view.textAlignment = .center
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.rgb(red: 97, green: 177, blue: 90)
        
        
       
        self.addSubview(tracking)
        tracking.addArrangedSubview(donations)
        tracking.addArrangedSubview(requests)
        
        
        
        
        self.addSubview(nameDes)
        self.addSubview(stack)
        
        stack.addArrangedSubview(profileImageView)
        let sv2 = UIStackView()
        profileImageView.widthAnchor.constraint(equalToConstant:70).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        profileImageView.layer.cornerRadius = 35
        profileImageView.clipsToBounds = true
        
        sv2.alignment = .fill
        sv2.distribution = .fill
        sv2.axis = .vertical
        sv2.addArrangedSubview(name)
        sv2.addArrangedSubview(nameDes)
        stack.addArrangedSubview(sv2)
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .leading
        
        
        stack.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        tracking.anchor(top: self.topAnchor, left: nil, bottom: nil, right: self.rightAnchor
            , paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: -10, width: 0, height: 0)
        
        self.addSubview(sub)
        sub.anchor(top: stack.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        sub.backgroundColor = .white
        
    }
    
    var user: User? {
        didSet {
            setupProfileImage()
        }
    }
    
    fileprivate func setupProfileImage() {
        guard let profileImageUrl = user?.profileImageUrl else { return }
        
        guard let url = URL(string: profileImageUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            //check for the error, then construct the image using data
            if let err = err {
                print("Failed to fetch profile image:", err)
                return
            }
            
            //perhaps check for response status of 200 (HTTP OK)
            
            guard let data = data else { return }
            
            let image = UIImage(data: data)
            
            //need to get back onto the main UI thread
            DispatchQueue.main.async {
                self.profileImageView.image = image
            }
            
            }.resume()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

