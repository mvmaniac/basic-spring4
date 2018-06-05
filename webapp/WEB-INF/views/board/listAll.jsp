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

<!-- main content -->
<section class="content">
    <!-- container-fluid -->
    <div class="container-fluid">
        <!-- row -->
        <div class="row">
            <div class="col-md-12">
                <div class="card card-default card-dark">
                    <div class="card-header">
                        <h3 class="card-title">List</h3>
                    </div>
                    <div class="card-body">
                        <table class="table table-bordered">
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
                                            <td>${board.bno}</td>
                                            <td><a href="<c:url value="/board/read?bno=${board.bno}" />">${board.title}</a></td>
                                            <td>${board.writer}</td>
                                            <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${board.regdate}" /></td>
                                            <td><span class="badge bg-red">${board.viewcnt}</span></td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </table>
                    </div>
                    <div class="card-footer clearfix">
                        <button type="button" class="btn btn-primary btn-sm float-left" id="register">Register</button>
                        <ul class="pagination pagination-sm m-0 float-right">
                            <li class="page-item"><a class="page-link" href="#">&laquo;</a></li>
                            <li class="page-item"><a class="page-link" href="#">1</a></li>
                            <li class="page-item"><a class="page-link" href="#">2</a></li>
                            <li class="page-item"><a class="page-link" href="#">3</a></li>
                            <li class="page-item"><a class="page-link" href="#">&raquo;</a></li>
                        </ul>
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

        initPage();
        initEvent();
    };
    
    function initPage() {

        var $result = $("#result"),
            value = $result.val();

        if (!value) { return; }

        // TODO: 모달창 넣기
        alert(value);

        $result.val("");
    }

    function initEvent() {

        var $register = $("#register");

        $register.click(function () {
           self.location.href = "register";
        });
    }
</script>