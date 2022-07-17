package bean.java;

public class Record_Bean {
    String [][] tableRecord = null;         //装数据库中导出来的商品数据
    int pageSize = 3;                   //每页默认显示的商品数
    int totalPages = 1;                 //总页数
    int currentPage = 1;                //当前页面
    int totalReCords;                   //总的商品数量

    public String[][] getTableRecord() {
        return tableRecord;
    }
    public void setTableRecord(String[][] tableRecord) {
        this.tableRecord = tableRecord;
    }
    public int getPageSize() {
        return pageSize;
    }
    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }
    public int getTotalPages() {
        return totalPages;
    }
    public void setTotalPages(int totalPages) {
        this.totalPages = totalPages;
    }
    public int getCurrentPage() {
        return currentPage;
    }
    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }
    public int getTotalReCords() {
        totalReCords = tableRecord.length;
        return totalReCords;
    }
    public void setTotalReCords(int totalReCords) {
        this.totalReCords = totalReCords;
    }

}
