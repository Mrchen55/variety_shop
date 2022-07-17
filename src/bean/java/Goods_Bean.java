package bean.java;

public class Goods_Bean {
    int    goodsAmount;             //商品数量
    String merchant;                //商家名字
    String goodsName;               //商品名称
    String goodsNumber;             //商品编号
    String goodsPrice;              //商品价格
    String goodsDate;               //商品生产日期
    String goodsClassify;           //商品类别
    String goodsPicture;            //商品图片名称
    String goodsIntroduce;          //商品介绍
    String goodsMade;               //制作方
    String mess="未上传图片";                    //反馈商品的信息

    public String getMess() {
        return mess;
    }
    public void setMess(String mess) {
        this.mess = mess;
    }
    public int getGoodsAmount() {
        return goodsAmount;
    }
    public void setGoodsAmount(int goodsAmount) {
        this.goodsAmount = goodsAmount;
    }
    public String getMerchant() {
        return merchant;
    }
    public void setMerchant(String merchant) {
        this.merchant = merchant;
    }
    public String getGoodsName() {
        return goodsName;
    }
    public void setGoodsName(String goodsName) {
        this.goodsName = goodsName;
    }
    public String getGoodsNumber() {
        return goodsNumber;
    }
    public void setGoodsNumber(String goodsNumber) {
        this.goodsNumber = goodsNumber;
    }
    public String getGoodsPrice() {
        return goodsPrice;
    }
    public void setGoodsPrice(String goodsPrice) {
        this.goodsPrice = goodsPrice;
    }
    public String getGoodsDate() {
        return goodsDate;
    }
    public void setGoodsDate(String goodsDate) {
        this.goodsDate = goodsDate;
    }
    public String getGoodsClassify() {
        return goodsClassify;
    }
    public void setGoodsClassify(String goodsClassify) {
        this.goodsClassify = goodsClassify;
    }
    public String getGoodsPicture() {
        return goodsPicture;
    }
    public void setGoodsPicture(String goodsPicture) {
        this.goodsPicture = goodsPicture;
    }
    public String getGoodsIntroduce() {
        return goodsIntroduce;
    }
    public void setGoodsIntroduce(String goodsIntroduce) {
        this.goodsIntroduce = goodsIntroduce;
    }
    public String getGoodsMade() {
        return goodsMade;
    }
    public void setGoodsMade(String goodsMade) {
        this.goodsMade = goodsMade;
    }
}
