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
import FirebaseStorage

//-----------------------------------------------------------------------------------------------------------------------------------------------
class PostOptionsView: UIViewController {
    
    var post: [String: Any]?

	//-------------------------------------------------------------------------------------------------------------------------------------------
	override func viewDidLoad() {

		super.viewDidLoad()
	}

	// MARK: - User actions
	//-------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionCopyLink(_ sender: UIButton) {
        if let documentId = post?["documentId"] as? String {
            let db = Firestore.firestore()
            db.collection("posts").document(documentId).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
            }
        }
        
        if let imageUrl = post?["imageUrl"] as? String {
            let storage = Storage.storage()
            let storageRef = storage.reference()
            // Create a reference to the file to delete
            let ref = storageRef.child(imageUrl)

            // Delete the file
            ref.delete { error in
              if let error = error {
                // Uh-oh, an error occurred!
              } else {
                // File deleted successfully
              }
            }
        }
        
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionReport(_ sender: UIButton) {

		print(#function)
		dismiss(animated: true)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionCancel(_ sender: UIButton) {

		print(#function)
		dismiss(animated: true)
	}
}
