package bean.java;

public class Register_Bean {
    int phone;              //电话
    String password;           //密码
    String address;         //地址
    String userName;        //真实名字
    String merchant;        //商家名
    String backNews;         //反馈信息
    public String getBackNews() {
        return backNews;
    }
    public void setBackNews(String backnews) {
        this.backNews = backnews;
    }
    public int getPhone() {
        return phone;
    }
    public void setPhone(int phone) {
        this.phone = phone;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }
    public String getUserName() {
        return userName;
    }
    public void setUserName(String userName) {
        this.userName = userName;
    }
    public String getMerchant() {
        return merchant;
    }
    public void setMerchant(String merchant) {
        this.merchant = merchant;
    }
}
