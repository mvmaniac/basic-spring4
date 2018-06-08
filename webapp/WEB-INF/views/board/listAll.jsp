<%--suppress XmlPathReference ELValidationInJSP ES6ConvertVarToLetConst --%>
<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- content header (page header) -->
<section class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1 class="m-0 text-dark">Board List</h1>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="<c:url value="/" />">Home</a></li>
                    <li class="breadcrumb-item active">Board List</li>
                </ol>
            </div>
        </div>
    </div>
</section>
<!-- // content-header -->

<c:set var="criteria" value="${paging.criteria}" />
<c:set var="rowNum" value="${paging.totalRowCount - ((criteria.page - 1) * criteria.perPageNum)}" />

<!-- main content -->
<section class="content">
    <!-- container-fluid -->
    <div class="container-fluid">
        <!-- row -->
        <div class="row">
            <div class="col-md-12">
                <div class="card card-default card-dark">
                    <div class="card-header">
                        <h3 class="card-title">Search</h3>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-12 col-sm-6 col-xl-4">
                                <select class="form-control" id="searchType" name="searchType" title="">
                                    <option value="n" <c:out value="${criteria.searchType == null ? 'selected' : ''}" />>---</option>
                                    <option value="t" <c:out value="${criteria.searchType eq 't' ? 'selected' : ''}" />>Title</option>
                                    <option value="c" <c:out value="${criteria.searchType eq 'c' ? 'selected' : ''}" />>Content</option>
                                    <option value="w" <c:out value="${criteria.searchType eq 'w' ? 'selected' : ''}" />>Writer</option>
                                    <option value="tc" <c:out value="${criteria.searchType eq 'tc' ? 'selected' :' '}" />>Title OR Content</option>
                                    <option value="cw" <c:out value="${criteria.searchType eq 'cw' ? 'selected' : ''}" />> Content OR Writer</option>
                                    <option value="tcw" <c:out value="${criteria.searchType eq 'tcw' ? 'selected' : ''}" />>Title OR Content OR Writer</option>
                                </select>
                            </div>
                            <div class="col-12 col-sm-6 col-md-6 col-xl-4">
                                <div class="input-group">
                                    <input class="form-control" type="text" placeholder="Keyword input" id="keyword" value="${paging.criteria.keyword }">
                                    <div class="input-group-append">
                                        <button type="button" class="btn btn-info" id="search" title="Search">Search</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card card-default card-dark">
                    <div class="card-header">
                        <h3 class="card-title">List</h3>
                    </div>
                    <div class="card-body table-responsive p-0">
                        <table class="table table-hover table-bordered">
                            <tr>
                                <th style="width: 10px">No</th>
                                <th>Title</th>
                                <th>Writer</th>
                                <th>RegDate</th>
                                <th style="width: 40px">ViewCnt</th>
                            </tr>
                            <c:choose>
                                <c:when test="${empty list}">
                                    <tr>
                                        <td colspan="6" class="text-center font-weight-bold">등록된 글이 없습니다.</td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="board" items="${list}">
                                        <tr>
                                            <td>${rowNum}</td>
                                            <td><a href="<c:url value="/board/read?bno=${board.bno}&${paging.makeQuery(paging.selectPage)}" />">${board.title}</a></td>
                                            <td>${board.writer}</td>
                                            <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${board.regdate}" /></td>
                                            <td><span class="badge bg-red">${board.viewcnt}</span></td>
                                        </tr>
                                        <c:set var="rowNum" value="${rowNum - 1}" />
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </table>
                    </div>
                    <div class="card-footer clearfix">
                        <button type="button" class="btn btn-primary btn-sm float-left" id="register" title="Register">Register</button>
                        <c:if test="${not empty list}">
                            <ul class="pagination pagination-sm m-0 float-right">
                                <c:if test="${paging.showFirst}">
                                    <li class="page-item"><a class="page-link" href="<c:url value="/board/listAll?${paging.makeQuery(1)}" />">처음</a></li>
                                </c:if>

                                <c:if test="${paging.showPrevMore}">
                                    <li class="page-item"><a class="page-link" href="<c:url value="/board/listAll?${paging.makeQuery(paging.prevMorePage)}" />">&laquo;</a></li>
                                </c:if>

                                <c:if test="${paging.showPrev}">
                                    <li class="page-item"><a class="page-link" href="<c:url value="/board/listAll?${paging.makeQuery(paging.prevPage)}" />">&lt;</a></li>
                                </c:if>

                                <c:forEach begin="${paging.startPage}" end="${paging.endPage}" step="1" var="idx">
                                    <li class="page-item <c:out value="${paging.selectPage == idx ? 'active': ''}" />">
                                        <a class="page-link" href="<c:url value="/board//listAll?${paging.makeQuery(idx)}" />">${idx}</a>
                                    </li>
                                </c:forEach>

                                <c:if test="${paging.showNext}">
                                    <li class="page-item"><a class="page-link" href="<c:url value="/board/listAll?${paging.makeQuery(paging.nextPage)}" />">&gt;</a></li>
                                </c:if>

                                <c:if test="${paging.showNextMore}">
                                    <li class="page-item"><a class="page-link" href="<c:url value="/board/listAll?${paging.makeQuery(paging.nextMorePage)}" />">&raquo;</a></li>
                                </c:if>

                                <c:if test="${paging.showLast}">
                                    <li class="page-item"><a class="page-link" href="<c:url value="/board/listAll?${paging.makeQuery(paging.totalPageCount)}" />">마지막</a></li>
                                </c:if>
                            </ul>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
        <!-- // row -->
    </div>
    <!-- // container-fluid -->
</section>
<!-- // main content -->

<input type="hidden" value="${result}" id="result" />

<script type="text/javascript">

    window.onload = function() {

        initVars();
        initEventPage();
    };
    
    function initVars() {

        var $result = $("#result"),
            value = $result.val();

        if (!value) { return; }

        // TODO: 모달창 넣기
        alert(value);

        $result.val("");
    }

    function initEventPage() {

        var $register = $("#register"),
            $keyword = $("#keyword"),
            $search = $("#search");

        $register.click(function () {
           self.location.href = gContextPath +"/board/register?"+ searchQuery();
        });

        $keyword.keydown(function (evt) {
            if (evt.keyCode === 13) {
                search();
            }
        });

        $search.click(function () {
            search();
        });
    }

    function search() {
        self.location.href = gContextPath +"/board/listAll?"+ searchQuery();
    }

    function searchQuery() {
        return "page=1&perPageNum=${criteria.perPageNum}"+
        "&searchType="+ $("#searchType").val() +"&keyword="+ encodeURIComponent($("#keyword").val());
    }
</script>