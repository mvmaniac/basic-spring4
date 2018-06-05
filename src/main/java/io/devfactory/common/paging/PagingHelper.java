package io.devfactory.common.paging;

public class PagingHelper {

    public static Paging getPagingInfo(int totalRowCount, int pageNum, int perPageNum, int displayPageNum) {
        return getPagingInfo(totalRowCount, new Criteria(pageNum, perPageNum), displayPageNum);
    }

    public static Paging getPagingInfo(int totalRowCount, Criteria criteria) {
        return getPagingInfo(totalRowCount, criteria, 10);
    }

    public static Paging getPagingInfo(int totalRowCount, Criteria criteria, int displayPageNum) {

        Paging paging = new Paging();
        paging.setCriteria(criteria);

        if (totalRowCount < 1) {
            return paging;
        }

        int pageNum = criteria.getPage();
        int perPageNum = criteria.getPerPageNum();

        int totalPageCount; // 전체페이지수
        int startPage; 		// 현재그룹의 시작페이지 번호
        int endPage; 		// 현재그룹의 끝페이지 번호
        int selectPage; 	// 선택된 페이지 번호
        int prevPage; 	    // 이전 그룹의 시작페이지 번호
        int nextPage; 		// 다음 그룹의 시작페이지 번호
        int groupNo; 		// 페이지별 그룹넘버

        // 전체 페이지수 구하기
        int modular = 0;

        if ((totalRowCount % perPageNum) != 0) {
            // 나머지가 2, 3, 4, 5,...., 9이면
            modular = 1;
        }

        // 전체페이지수 = 전체행수 / 테이블당보여질행의수 + 나머지
        totalPageCount = totalRowCount / perPageNum + modular;

        // 현재그룹에서 시작페이지와 끝페이지, 그리고 이전 그룹의 시작페이지와 끝페이지, 그룹넘버 구하기.
        // 사용자가 페이지번호를 선택할 때마다 각각의 결과값 다르다.
        selectPage = pageNum;

        //1 ~10 --> 0 11~20 --> 1 21~30 --> 2 .....
        groupNo = (selectPage - 1) / displayPageNum;

        // 현재그룹의 시작페이지 번호
        startPage = groupNo * displayPageNum + 1;
        if (startPage > totalPageCount) {
            startPage = startPage - displayPageNum + 1;
        }

        // 현재그룹의 끝페이지 번호
        endPage = groupNo * displayPageNum + displayPageNum;
        if (endPage > totalPageCount) {
            endPage = totalPageCount;
        }

        // 이전 그룹의 시작페이지 번호
        prevPage = startPage - 1;
        if (prevPage < 0) {
            prevPage = 0;
        }

        // 다음 그룹의 시작페이지 번호
        nextPage = startPage + displayPageNum;

        // 페이징 처리에 필요한 정보 설정
        paging.setTotalRowCount(totalRowCount);
        paging.setTotalPageCount(totalPageCount);
        paging.setStartPage(startPage);
        paging.setEndPage(endPage);
        paging.setPrevMorePage(prevPage);
        paging.setPrevPage(selectPage - 1);
        paging.setSelectPage(selectPage);
        paging.setNextPage(selectPage + 1);
        paging.setNextMorePage(nextPage);

        paging.setShowFirst(isShowFirst(groupNo, totalPageCount));
        paging.setShowPrevMore(isShowPrevMore(groupNo,totalPageCount));
        paging.setShowPrev(isShowPrev(selectPage));
        paging.setShowNext(isShowNext(selectPage, totalPageCount));
        paging.setShowNextMore(isShowNextMore(endPage, totalPageCount));
        paging.setShowLast(isShowLast(endPage, totalPageCount));

        return paging;
    }

    // 현재그룹에서 [이전페이지] 출력여부 리턴
    public static boolean isShowPrev(int selectPage) {
        return (selectPage > 1);
    }

    // 현재그룹에서 [다음페이지] 출력여부 리턴
    public static boolean isShowNext(int selectPage, int totalPageCount) {
        return (selectPage < totalPageCount);
    }

    // 현재그룹에서 [이전그룹] 출력여부 리턴
    public static boolean isShowPrevMore(int groupNo, int totalPageCount) {

        int modular = groupNo % totalPageCount;

        if (modular != 0) {
            modular = 1;
        }

        return (groupNo / totalPageCount + modular) > 0;
    }

    // 현재그룹에서 [다음그룹] 출력여부 리턴
    public static boolean isShowNextMore(int endPage, int totalPageCount) {
        return endPage < totalPageCount;
    }

    // 현재그룹에서 [처음으로] 출력여부 리턴
    public static boolean isShowFirst(int groupNo, int totalPageCount) {

        int modular = groupNo % totalPageCount;

        if (modular != 0) {
            modular = 1;
        }

        return (groupNo / totalPageCount + modular) > 0;
    }

    // 현재그룹에서 [마자막으로] 출력여부 리턴
    public static boolean isShowLast(int endPage, int totalPageCount) {
        return endPage < totalPageCount;
    }

    // 테스트 메인
    public static void main(String[] args) {
        Paging paging = PagingHelper.getPagingInfo(351, 10, 30, 10);
        System.out.println("전체검색행수: " + paging.getTotalRowCount());
        System.out.println("선택페이지: " + paging.getSelectPage());
        System.out.println("총페이지 수: " + paging.getTotalPageCount());
        System.out.println("처음으로 보여줄지 여부: " + paging.isShowFirst());
        System.out.println("이전그룹 보여줄지 여부: " +	paging.isShowPrevMore());
        System.out.println("이전페이지 보여줄지 여부: " + paging.isShowPrev());
        System.out.println("다음페이지 보여줄지 여부: " + paging.isShowNext());
        System.out.println("다음그룹 보여줄지 여부: " + paging.isShowNextMore());
        System.out.println("마지막으로 보여줄지 여부: " + paging.isShowLast());
    }
}
