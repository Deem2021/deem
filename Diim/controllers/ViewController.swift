//
//  ViewController.swift
//  Diim
//
//  Created by Diim on 18/02/2021.
//

import UIKit


class ViewController: UIViewController, UIScrollViewDelegate {
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    var pageNumber = 0
    var slides:[slide] = [];
    let attributedStringButton = NSMutableAttributedString(string: "التالي", attributes: [
        .font: UIFont.textStyle18,
        .foregroundColor:  #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    ])
    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.delegate = self
        }
    }
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBAction func NextPage(_ sender: Any) {
        if pageNumber == 1{
            print("main")
            self.appDelegate?.Main()
        }
        else{
            self.pageNumber = self.pageNumber + 1
            pageControl.currentPage = pageNumber
            let page = pageNumber
            var frame = scrollView.frame;
            frame.origin.x = frame.size.width * CGFloat(page)
            frame.origin.y = 0
            self.scrollView.scrollRectToVisible(frame, animated: true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        buttonStyle(nextButton: nextButton)
        UserDefaults.standard.set(true, forKey: "onboardingComplete")
        slides = createSlides()
        setupSlideScrollView(slides: slides)
        pageControl.numberOfPages = slides.count
        view.bringSubviewToFront(pageControl)
    }
    func buttonStyle(nextButton:UIButton){

        nextButton.setTitle("التالي", for: .normal)
        nextButton.isHidden = false
        nextButton.setAttributedTitle(attributedStringButton, for: .normal)
        nextButton.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .normal)
        nextButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        nextButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    func createSlides() -> [slide] {
        
        let slide1:slide = Bundle.main.loadNibNamed("slide", owner: self, options: nil)?.first as! slide
   //     slide1.imageView.isHidden = true
        let attributedStringTitle = NSMutableAttributedString(string: "دِيم", attributes: [
            .font: UIFont.textStyle72,
            .foregroundColor: UIColor.aquaBlue
        ])
        slide1.labelTitle.attributedText = attributedStringTitle
        
        let attributedString = NSMutableAttributedString(string: "عن أبي صالح قال: سألت عائشة وام سلمة\n\nأي العمل كان احب إلى رسول الله صلى الله؟\nقالتا: ما دِيم عليه وإن قل.", attributes: [
            .font: UIFont.textStyle18,
            .foregroundColor: UIColor.melon
        ])
        attributedString.addAttribute(.font, value: UIFont.textStyle18, range: NSRange(location: 0, length: 36))
        attributedString.addAttribute(.foregroundColor, value: UIColor.aquaBlue, range: NSRange(location: 89, length: 5))
        slide1.labelDesc.attributedText = attributedString
        slide1.imageHeight.constant = 50
        slide1.imageView.layoutIfNeeded()
        let slide2:slide = Bundle.main.loadNibNamed("slide", owner: self, options: nil)?.first as! slide
        slide2.imageView.image = #imageLiteral(resourceName: "intro")
        slide2.labelTitle.attributedText = attributedStringTitle
        slide2.labelDesc.font = UIFont.textStyle24
        slide2.labelDesc.textColor = UIColor.melon
        slide2.labelDesc.text = "فكرتنا بسيطة \n تطوع .. وثق .. واجمع نقاطك"
        slide2.labelDesc2.font = UIFont.textStyle14
        slide2.labelDesc2.textColor = UIColor.brownGrey
        slide2.labelDesc2.text = "احصل على مكافئتك واستدم في تطوعك"
        slide2.imageHeight.constant = 200
        slide2.imageView.layoutIfNeeded()

        return [slide1, slide2]
    }
    
    
    func setupSlideScrollView(slides : [slide]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i])
            
        }
        if pageControl.currentPage == 0 {
            nextButton.setAttributedTitle(attributedStringButton, for: .normal)
        }
        else{
        if pageControl.currentPage == 1 {
            let attributedStringButton = NSMutableAttributedString(string: "ابدأ", attributes: [
                .font: UIFont.textStyle18,
                .foregroundColor:  #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            ])
            nextButton.setAttributedTitle(attributedStringButton, for: .normal)

        }
        }
    }
    
    /*
     * default function called when view is scolled. In order to enable callback
     * when scrollview is scrolled, the below code needs to be called:
     * slideScrollView.delegate = self or
     */
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        self.pageControl.currentPage = Int(pageIndex)
        self.pageNumber = Int(pageIndex)
        let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
        let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
        
        // vertical
        let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
        let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
        
        let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
        let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
        
        if pageControl.currentPage == 0{
           nextButton.setAttributedTitle(attributedStringButton, for: .normal)
        }
        else{
        if pageControl.currentPage == 1 {
            let attributedStringButton = NSMutableAttributedString(string: "ابدأ", attributes: [
                .font: UIFont.textStyle18,
                .foregroundColor:  #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            ])
            nextButton.setAttributedTitle(attributedStringButton, for: .normal)
            
        }
        }
    }
    func scrollView(_ scrollView: UIScrollView, didScrollToPercentageOffset percentageHorizontalOffset: CGFloat) {
        
        if(pageControl.currentPage == 0) {
            let pageUnselectedColor: UIColor = fade(fromRed: 255/255, fromGreen: 255/255, fromBlue: 255/255, fromAlpha: 1, toRed: 103/255, toGreen: 58/255, toBlue: 183/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
            pageControl.pageIndicatorTintColor = pageUnselectedColor
            
            
            let bgColor: UIColor = fade(fromRed: 103/255, fromGreen: 58/255, fromBlue: 183/255, fromAlpha: 1, toRed: 255/255, toGreen: 255/255, toBlue: 255/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
            slides[pageControl.currentPage].backgroundColor = bgColor
            
            let pageSelectedColor: UIColor = fade(fromRed: 81/255, fromGreen: 36/255, fromBlue: 152/255, fromAlpha: 1, toRed: 103/255, toGreen: 58/255, toBlue: 183/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
            pageControl.currentPageIndicatorTintColor = pageSelectedColor
        }
        
    }
    
    func fade(fromRed: CGFloat,
              fromGreen: CGFloat,
              fromBlue: CGFloat,
              fromAlpha: CGFloat,
              toRed: CGFloat,
              toGreen: CGFloat,
              toBlue: CGFloat,
              toAlpha: CGFloat,
              withPercentage percentage: CGFloat) -> UIColor {
        
        let red: CGFloat = (toRed - fromRed) * percentage + fromRed
        let green: CGFloat = (toGreen - fromGreen) * percentage + fromGreen
        let blue: CGFloat = (toBlue - fromBlue) * percentage + fromBlue
        let alpha: CGFloat = (toAlpha - fromAlpha) * percentage + fromAlpha
        
        // return the fade colour
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
