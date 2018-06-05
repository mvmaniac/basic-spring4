package io.devfactory.common.paging;

public class Paging {

    private Criteria criteria;      // 페이징 검색 정보

    private int totalRowCount;		// 전체목록수
    private int totalPageCount; 	// 전체페이지수
    private int startPage; 		    // 현재그룹의 시작페이지 번호
    private int endPage; 			// 현재그룹의 끝페이지 번호
    private int prevMorePage; 	    // 이전 그룹의 시작페이지 번호
    private int prevPage; 	        // 이전 페이지 번호
    private int selectPage;		    // 선택된 페이지 번호
    private int nextPage; 		    // 다음 페이지 번호
    private int nextMorePage; 		// 다음 그룹의 시작페이지 번호
    private int groupNo; 			// 페이지별 그룹넘버

    private boolean showFirst;		// 처음으로 보여줄지 여부
    private boolean showPrevMore;   // 이전그룹 보여줄지 여부
    private boolean showPrev;		// 이전페이지 보여줄지 여부
    private boolean showNext;		// 다음페이지 보여줄지 여부
    private boolean showNextMore;	// 다음그룹 보여줄지 여부
    private boolean showLast;		// 마지막으로 보여줄지 여부

    public Paging() {}

    public Criteria getCriteria() {
        return criteria;
    }

    public void setCriteria(Criteria criteria) {
        this.criteria = criteria;
    }

    public int getTotalRowCount() {
        return totalRowCount;
    }

    public void setTotalRowCount(int totalRowCount) {
        this.totalRowCount = totalRowCount;
    }

    public int getTotalPageCount() {
        return totalPageCount;
    }

    public void setTotalPageCount(int totalPageCount) {
        this.totalPageCount = totalPageCount;
    }

    public int getStartPage() {
        return startPage;
    }

    public void setStartPage(int startPage) {
        this.startPage = startPage;
    }

    public int getEndPage() {
        return endPage;
    }

    public void setEndPage(int endPage) {
        this.endPage = endPage;
    }

    public int getPrevMorePage() {
        return prevMorePage;
    }

    public void setPrevMorePage(int prevMorePage) {
        this.prevMorePage = prevMorePage;
    }

    public int getPrevPage() {
        return prevPage;
    }

    public void setPrevPage(int prevPage) {
        this.prevPage = prevPage;
    }

    public int getSelectPage() {
        return selectPage;
    }

    public void setSelectPage(int selectPage) {
        this.selectPage = selectPage;
    }

    public int getNextPage() {
        return nextPage;
    }

    public void setNextPage(int nextPage) {
        this.nextPage = nextPage;
    }

    public int getNextMorePage() {
        return nextMorePage;
    }

    public void setNextMorePage(int nextMorePage) {
        this.nextMorePage = nextMorePage;
    }

    public int getGroupNo() {
        return groupNo;
    }

    public void setGroupNo(int groupNo) {
        this.groupNo = groupNo;
    }

    public boolean isShowFirst() {
        return showFirst;
    }

    public void setShowFirst(boolean showFirst) {
        this.showFirst = showFirst;
    }

    public boolean isShowPrevMore() {
        return showPrevMore;
    }

    public void setShowPrevMore(boolean showPrevMore) {
        this.showPrevMore = showPrevMore;
    }

    public boolean isShowPrev() {
        return showPrev;
    }

    public void setShowPrev(boolean showPrev) {
        this.showPrev = showPrev;
    }

    public boolean isShowNext() {
        return showNext;
    }

    public void setShowNext(boolean showNext) {
        this.showNext = showNext;
    }

    public boolean isShowNextMore() {
        return showNextMore;
    }

    public void setShowNextMore(boolean showNextMore) {
        this.showNextMore = showNextMore;
    }

    public boolean isShowLast() {
        return showLast;
    }

    public void setShowLast(boolean showLast) {
        this.showLast = showLast;
    }

    public String makeQuery(int page) {
        return criteria.makeQuery(page);
    }

    @Override
    public String toString() {
        return "Paging{" +
                "criteria=" + criteria +
                ", totalRowCount=" + totalRowCount +
                ", totalPageCount=" + totalPageCount +
                ", startPage=" + startPage +
                ", endPage=" + endPage +
                ", prevMorePage=" + prevMorePage +
                ", prevPage=" + prevPage +
                ", selectPage=" + selectPage +
                ", nextPage=" + nextPage +
                ", nextMorePage=" + nextMorePage +
                ", groupNo=" + groupNo +
                ", showFirst=" + showFirst +
                ", showPrevMore=" + showPrevMore +
                ", showPrev=" + showPrev +
                ", showNext=" + showNext +
                ", showNextMore=" + showNextMore +
                ", showLast=" + showLast +
                '}';
    }
}
