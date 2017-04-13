//
//  MySellConfimHeaderTableViewCell.swift
//  LiangPiao
//
//  Created by Zhang on 15/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class MySellConfimHeaderTableViewCell: UITableViewCell {

    var ticketTitle:UILabel!
    var ticketTime:UILabel!
    var ticketLoacation:UILabel!
    var lineLabel:GloabLineView!
    var didMakeContraints:Bool = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView() {
        
        ticketTitle = UILabel()
        ticketTitle.text = "孟京辉大型多媒体音乐话剧《琥珀》 "
        ticketTitle.numberOfLines = 0
        ticketTitle.textColor = UIColor.init(hexString: App_Theme_384249_Color)
        ticketTitle.font = App_Theme_PinFan_R_18_Font
        self.contentView.addSubview(ticketTitle)
        
        ticketTime = UILabel()
        ticketTime.text = "2016.10.14 周五 20:00"
        ticketTime.textColor = UIColor.init(hexString: App_Theme_A2ABB5_Color)
        ticketTime.font = App_Theme_PinFan_R_13_Font
        self.contentView.addSubview(ticketTime)
        
        ticketLoacation = UILabel()
        ticketLoacation.text = "保利剧院"
        ticketLoacation.textColor = UIColor.init(hexString: App_Theme_A2ABB5_Color)
        ticketLoacation.font = App_Theme_PinFan_R_13_Font
        self.contentView.addSubview(ticketLoacation)
        
        lineLabel = GloabLineView(frame: CGRect(x: 15, y: self.contentView.bounds.size.height - 0.5, width: SCREENWIDTH - 30, height: 0.5))
        self.contentView.addSubview(lineLabel)
        
        self.updateConstraintsIfNeeded()
    }
    
    func setUpData(_ model:TicketShowModel){
        ticketTitle.text = model.title
        UILabel.changeLineSpace(for: ticketTitle, withSpace: TitleLineSpace)
        ticketTime.text = model.session.startTime
        ticketLoacation.text = model.venue.name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        if !self.didMakeContraints {
        
            ticketTitle.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.top.equalTo(self.contentView.snp.top).offset(28)
            })
            
            ticketTime.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.top.equalTo(self.ticketTitle.snp.bottom).offset(4)
            })
            
            ticketLoacation.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.top.equalTo(self.ticketTime.snp.bottom).offset(1)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-28)
            })
            
            lineLabel.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-0.5)
            })
            self.didMakeContraints = true
            
        }
        super.updateConstraints()
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
