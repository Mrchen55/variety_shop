package bean.java;

public class Login_Bean {
    String username="";             //用户名
    String userClass="";            //用户类别
    String news="未登录";             //登录状态

    public String getUserClass() {
        return userClass;
    }
    public void setUserClass(String userClass) {
        this.userClass = userClass;
    }
    public String getUsername() {
        return username;
    }
    public void setUsername(String id) {
        this.username = id;
    }
    public String getNews() {
        return news;
    }
    public void setNews(String news) {
        this.news = news;
    }
}
