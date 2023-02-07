//
// Copyright (c) 2021 Related Code - https://relatedcode.com
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

class AddPostView: UIViewController {
    let viewModel = AddPostViewModel()
    
	@IBOutlet var imageUser: UIImageView!
	@IBOutlet var labelUser: UILabel!
	@IBOutlet var textViewPost: UITextView!
    @IBOutlet weak var imagePost: UIImageView!
    
    let cameraHandler = CameraHandler()
    var postImageUrl: URL?
    
    private var placeholderLabel = UILabel()

	override func viewDidLoad() {
		super.viewDidLoad()
		initUI()
		setup()
	}

    override func viewWillDisappear(_ animated: Bool) {
        presentingViewController?.viewWillAppear(animated)
    }
    
    func initUI() {
        title = "Create Post"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(actionCancel(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Publish", style: .done, target: self, action: #selector(actionPublish(_:)))
        
        placeholderLabel.font = textViewPost.font
        placeholderLabel.frame.origin = CGPoint(x: 5, y: textViewPost.font!.pointSize / 2)
        placeholderLabel.textColor = UIColor.quaternaryLabel
        placeholderLabel.isHidden = !textViewPost.text.isEmpty
        textViewPost.addSubview(placeholderLabel)
    }
    
	func setup() {
        placeholderLabel.text = "What’s new, \(viewModel.firstName)?"
        placeholderLabel.sizeToFit()
        labelUser.text = viewModel.name
        imageUser.sd_setImage(with: viewModel.imageUserUrl, placeholderImage: UIImage(named: "logo"))
        cameraHandler.imagePickedBlock = { [weak self] (imageUrl, image) in
            self?.postImageUrl = imageUrl
            self?.imagePost.image = image
        }
	}

	@objc func actionCancel(_ sender: UIButton) {
		dismiss(animated: true)
	}

    @objc func actionPublish(_ sender: UIButton) {
        viewModel.addPost(message: textViewPost.text, postImageUrl: postImageUrl) { [weak self] in
            self?.dismiss(animated: true)
        }
        
	}

	@IBAction func actionMedia(_ sender: UIButton) {
        cameraHandler.photoLibrary(vc: self)
	}

	
	@IBAction func actionCamera(_ sender: UIButton) {
        cameraHandler.camera(vc: self)
	}
}

extension AddPostView: UITextViewDelegate {
	func textViewDidChange(_ textView: UITextView) {
		placeholderLabel.isHidden = !textView.text.isEmpty
	}
}
