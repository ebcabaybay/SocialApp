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

	@IBOutlet var imageUser: UIImageView!
	@IBOutlet var labelUser: UILabel!
	@IBOutlet var textViewPost: UITextView!
    @IBOutlet weak var imagePost: UIImageView!
    
    var user: User!
    var postImageUrl: URL?
    
    private var placeholderLabel = UILabel()

	override func viewDidLoad() {

		super.viewDidLoad()
		title = "Create Post"
		navigationController?.navigationBar.prefersLargeTitles = false
		navigationItem.largeTitleDisplayMode = .never

		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(actionCancel(_:)))
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Publish", style: .done, target: self, action: #selector(actionDone(_:)))

		loadData()
        
        CameraHandler.shared.imagePickedBlock = { [weak self] (imageUrl, image) in
            self?.postImageUrl = imageUrl
            self?.imagePost.image = image
        }
	}

	func loadData() {

		imageUser.sample("Social", "Portraits", 4)
		labelUser.text = "John Smith"

		placeholderLabel.text = "What’s new, John?"
		placeholderLabel.font = textViewPost.font
		placeholderLabel.sizeToFit()
		placeholderLabel.frame.origin = CGPoint(x: 5, y: textViewPost.font!.pointSize / 2)
		placeholderLabel.textColor = UIColor.quaternaryLabel
		placeholderLabel.isHidden = !textViewPost.text.isEmpty
		textViewPost.addSubview(placeholderLabel)
	}

	@objc func actionCancel(_ sender: UIButton) {
		dismiss(animated: true)
	}

    @objc func actionDone(_ sender: UIButton) {
        var post = Post(documentId: "", data: [:])
        post.user = user
        post.message = textViewPost.text
        post.imageUrl = postImageUrl
        
        PostApiService.addPost(post: post).request { [weak self] (result: Result<Post>) in
            switch result {
                case .success(_):
                    self?.dismiss(animated: true)
                case .failure(let error):
                    print(error)
            }
        }
	}

	@IBAction func actionMedia(_ sender: UIButton) {
        CameraHandler.shared.photoLibrary(vc: self)
	}

	
	@IBAction func actionCamera(_ sender: UIButton) {
        CameraHandler.shared.camera(vc: self)
	}
}

extension AddPostView: UITextViewDelegate {
	func textViewDidChange(_ textView: UITextView) {
		placeholderLabel.isHidden = !textView.text.isEmpty
	}
}
