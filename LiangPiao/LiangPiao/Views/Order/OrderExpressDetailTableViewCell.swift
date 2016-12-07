//
//  OrderExpressDetailTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 07/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class OrderExpressDetailTableViewCell: UITableViewCell {

    var detailLabel:UILabel!
    
    var lineLabel:GloabLineView!
    
    var didMakeConstraints:Bool = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView() {
        
        detailLabel = UILabel()
        detailLabel.font = App_Theme_PinFan_R_13_Font
        detailLabel.text = "北京市崇文区东花市北里20号楼6单元501室"
        detailLabel.textColor = UIColor.init(hexString: App_Theme_556169_Color)
        self.contentView.addSubview(detailLabel)
        
        lineLabel = GloabLineView(frame: CGRect.init(x: 15, y: 44.5, width: SCREENWIDTH - 30, height: 0.5))
        self.contentView.addSubview(lineLabel)
        
        self.updateConstraintsIfNeeded()
    }
    
    func hiderLineLabel(){
        lineLabel.hidden = true
    }
    
    func setData(detail:String){
        detailLabel.text = detail
        self.updateConstraintsIfNeeded()
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            detailLabel.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self.contentView.snp_left).offset(15)
                make.centerY.equalTo(self.contentView.snp_centerY).offset(0)
            })
            
            self.didMakeConstraints = true
        }
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
