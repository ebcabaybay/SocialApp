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
import FirebaseFirestore
import FirebaseAuth

//-----------------------------------------------------------------------------------------------------------------------------------------------
class AddPostView: UIViewController {

	@IBOutlet var imageUser: UIImageView!
	@IBOutlet var labelUser: UILabel!
	@IBOutlet var buttonPrivacy: UIButton!
	@IBOutlet var textViewPost: UITextView!

	private var placeholderLabel = UILabel()

	//-------------------------------------------------------------------------------------------------------------------------------------------
	override func viewDidLoad() {

		super.viewDidLoad()
		title = "Create Post"
		navigationController?.navigationBar.prefersLargeTitles = false
		navigationItem.largeTitleDisplayMode = .never

		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(actionCancel(_:)))
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Publish", style: .done, target: self, action: #selector(actionDone(_:)))

		loadData()
	}

	// MARK: - Data methods
	//-------------------------------------------------------------------------------------------------------------------------------------------
	func loadData() {

		imageUser.sample("Social", "Portraits", 4)
		labelUser.text = "John Smith"
		buttonPrivacy.setTitle("Public", for: .normal)

		placeholderLabel.text = "What’s new, John?"
		placeholderLabel.font = textViewPost.font
		placeholderLabel.sizeToFit()
		placeholderLabel.frame.origin = CGPoint(x: 5, y: textViewPost.font!.pointSize / 2)
		placeholderLabel.textColor = UIColor.quaternaryLabel
		placeholderLabel.isHidden = !textViewPost.text.isEmpty
		textViewPost.addSubview(placeholderLabel)
	}

	// MARK: - User actions
	//-------------------------------------------------------------------------------------------------------------------------------------------
	@objc func actionCancel(_ sender: UIButton) {

		print(#function)
		dismiss(animated: true)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	@objc func actionDone(_ sender: UIButton) {
        let message = textViewPost.text
        let user = Auth.auth().currentUser
        
        let db = Firestore.firestore()
        var ref: DocumentReference? = nil
        ref = db.collection("posts").addDocument(data: [
            "message": message,
            "imageUrl": nil,
            "userId": user?.uid,
            "userName": user?.email,
            "displayName": user?.displayName,
            "date": Date()
        ]) { [weak self] err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
            self?.dismiss(animated: true)
        }
//		print(#function)
//		dismiss(animated: true)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionPrivacy(_ sender: UIButton) {

		print(#function)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionMedia(_ sender: UIButton) {

		print(#function)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionTagFriend(_ sender: UIButton) {

		print(#function)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionFeeling(_ sender: UIButton) {

		print(#function)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionCamera(_ sender: UIButton) {

		print(#function)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionCheckIn(_ sender: UIButton) {

		print(#function)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionLiveVideo(_ sender: UIButton) {

		print(#function)
	}
}

// MARK: - UITableViewDelegate
//-----------------------------------------------------------------------------------------------------------------------------------------------
extension AddPostView: UITextViewDelegate {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func textViewDidChange(_ textView: UITextView) {

		placeholderLabel.isHidden = !textView.text.isEmpty
	}
}
