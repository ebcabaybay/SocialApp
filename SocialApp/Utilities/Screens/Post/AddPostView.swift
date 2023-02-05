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
import FirebaseStorage

//-----------------------------------------------------------------------------------------------------------------------------------------------
class AddPostView: UIViewController {

	@IBOutlet var imageUser: UIImageView!
	@IBOutlet var labelUser: UILabel!
	@IBOutlet var buttonPrivacy: UIButton!
	@IBOutlet var textViewPost: UITextView!
    @IBOutlet weak var imagePost: UIImageView!
    var postImageUrl: URL?
    
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
        
        CameraHandler.shared.imagePickedBlock = { [weak self] (imageUrl, image) in
            /* get your image here */
            self?.postImageUrl = imageUrl
            self?.imagePost.image = image
        }
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
                if let postImageUrl = self?.postImageUrl {
                    let storage = Storage.storage()
                    let storageRef = storage.reference()
                    let imageUrl = "images/" + ref!.documentID + postImageUrl.lastPathComponent
                    let imagesRef = storageRef.child(imageUrl)
                    
                    let uploadTask = imagesRef.putFile(from: postImageUrl, metadata: nil) { metadata, error in
                      guard let metadata = metadata else {
                        // Uh-oh, an error occurred!
                        return
                      }
                      // Metadata contains file metadata such as size, content-type.
//                      let size = metadata.size
//                      // You can also access to download URL after upload.
//                        imagesRef.downloadURL { (url, error) in
//                        guard let downloadURL = url else {
//                          // Uh-oh, an error occurred!
//                          return
//                        }
                            
                        db.collection("posts").document(ref!.documentID).updateData([
                            "imageUrl": imageUrl,
                            ]) { err in
                                if let err = err {
                                    print("Error updating document: \(err)")
                                } else {
                                    print("Document successfully updated")
                                }
                                self?.dismiss(animated: true)
                            }
//                      }
                    }
                } else {
                    self?.dismiss(animated: true)
                }
            }
        }
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionPrivacy(_ sender: UIButton) {

		print(#function)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionMedia(_ sender: UIButton) {
        CameraHandler.shared.photoLibrary(vc: self)
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
        CameraHandler.shared.camera(vc: self)
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
