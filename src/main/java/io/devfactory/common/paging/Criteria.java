package io.devfactory.common.paging;

public class Criteria {

    private int page;
    private int perPageNum;

    public Criteria() {
        this(1, 10);
    }

    public Criteria(int page, int perPageNum) {
        this.page = page;
        this.perPageNum = perPageNum;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {

        if (page <= 0) {
            this.page = 1;
            return;
        }

        this.page = page;
    }

    public void setPerPageNum(int perPageNum) {

        if (perPageNum <= 0 || perPageNum > 1000) {
            this.perPageNum = 10;
            return;
        }

        this.perPageNum = perPageNum;
    }

    // method for MyBatis SQL Mapper
    public int getPerPageNum() {
        return perPageNum;
    }

    // method for MyBatis SQL Mapper
    public int getPageStart() {
        return (this.page - 1) * perPageNum;
    }

    public String makeQuery(int page) {
        return "page="+ page +"&perPageNum="+ perPageNum;
    }

    @Override
    public String toString() {
        return "Criteria{" +
                "page=" + page +
                ", perPageNum=" + perPageNum +
                '}';
    }
}
