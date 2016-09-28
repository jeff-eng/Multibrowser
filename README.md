# Multibrowser
Repo following Project 31: Multibrowser at Hacking with Swift

## Concepts learned/practiced
* Learned:
  * UIStackView
    * Adding views to UIStackView using ```addArrangedSubview()``` method
      * Adds to the arranged subviews array; stack view will arrange them as needed.
    * Removing views from UIStackView using ```removeArrangedSubview``` method
      * Also needing to call ```removeFromSuperview()``` method to remove the deleted web views entirely.
  * Size classes
    * Horizontal and Vertical axes combined with either compact or regular size class
    * The ```traitCollectionDidChange``` method gets called automatically when the size class changes, then query the current size class and adapt the UI based on this information.
  * iPad multitasking
    * Slide over
    * Split view
  * ```UITapGestureRecognizer``` class
  * ```textFieldShouldReturn()``` delegate method to notify us when user presses return on the keyboard
  * ```resignFirstResponder()``` method so keyboard hides when deselecting the text field
* Practiced:
  * Using optional unwrapping with ```if let```

## Attributions
[Project 31: Multibrowser at Hacking with Swift](https://www.hackingwithswift.com/read/31/overview)
