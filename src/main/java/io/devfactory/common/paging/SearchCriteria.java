package io.devfactory.common.paging;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

public class SearchCriteria extends Criteria {

    private String searchType;
    private String keyword;

    public SearchCriteria() {
        super();
        searchType = "";
        keyword = "";
    }

    public SearchCriteria(int page, int perPageNum) {
        this(page, perPageNum, "", "");
    }

    public SearchCriteria(int page, int perPageNum, String searchType, String keyword) {
        super(page, perPageNum);
        this.searchType = searchType;
        this.keyword = keyword;
    }

    public String getSearchType() {
        return searchType;
    }

    public void setSearchType(String searchType) {
        this.searchType = searchType;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public String makeQuery(int page) {
        return super.makeQuery(page) +"&searchType="+ searchType +"&keyword="+ encoding(keyword);
    }

    private String encoding(String keyword) {

        if (keyword == null || keyword.trim().length() == 0) {
            return "";
        }

        try {
            return URLEncoder.encode(keyword, StandardCharsets.UTF_8.toString());
        } catch (UnsupportedEncodingException e) {
            return "";
        }
    }

    @Override
    public String toString() {
        return "SearchCriteria{" +
                "searchType='" + searchType + '\'' +
                ", keyword='" + keyword + '\'' +
                "} " + super.toString();
    }
}
