<%--suppress ES6ConvertVarToLetConst --%>
<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- content header (page header) -->
<section class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1 class="m-0 text-dark">Board Modify</h1>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="<c:url value="/" />">Home</a></li>
                    <li class="breadcrumb-item active">Board Modify</li>
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
                        <h3 class="card-title">Modify Form</h3>
                    </div>
                    <div class="card-body">
                        <form role="form" method="post" id="frmModify">
                            <input type="hidden" id="bno" name="bno" value="${boardVO.bno}" />
                            <input type="hidden" id="page" name="page" value="${cri.page}" />
                            <input type="hidden" id="perPageNum" name="perPageNum" value="${cri.perPageNum}" />
                            <input type="hidden" id="searchType" name="searchType" value="${cri.searchType}" />
                            <input type="hidden" id="keyword" name="keyword" value="${cri.keyword}" />
                            <div class="form-group">
                                <label for="title">Title</label>
                                <input type="text" class="form-control" id="title" name="title" value="${boardVO.title}" />
                            </div>
                            <div class="form-group">
                                <label for="content">Content</label>
                                <textarea class="form-control" rows="3" id="content" name="content">${boardVO.content}</textarea>
                            </div>
                            <div class="form-group">
                                <label for="writer">Writer</label>
                                <input type="text" class="form-control" id="writer" name="writer" value="${boardVO.writer}" readonly />
                            </div>
                        </form>
                    </div>
                    <div class="card-footer">
                        <button type="submit" class="btn btn-primary btn-sm" id="save">Save</button>
                        <button type="submit" class="btn btn-warning btn-sm" id="cancel">Cancel</button>
                        <button type="button" class="btn btn-default btn-sm" id="list">List All</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- // row -->
    </div>
    <!-- // container-fluid -->
</section>
<!-- // main content -->

<script type="text/javascript">

    window.onload = function() {

        initVars();
        initEventPage();
    };

    function initVars() {}

    function initEventPage() {

        var $form = $("#frmModify"),
            $save = $("#save"),
            $cancel = $("#cancel"),
            $list = $("#list");

        // TODO: 유효성 체크
        $save.click(function (evt) {

            evt.preventDefault();

            $form.attr("action", "modify");
            $form.attr("method", "post");

            $form.submit();
        });

        $cancel.click(function () {
            self.location.href = gContextPath +"/board/read?bno="+ $("#bno").val() +"&"+ searchQuery();
        });

        $list.click(function () {
            self.location.href = gContextPath +"/board/listAll?"+ searchQuery();
        });
    }

    function searchQuery() {
        return "page="+ $("#page").val() +"&perPageNum="+ $("#perPageNum").val()
        +"&searchType="+ $("#searchType").val() +"&keyword="+ $("#keyword").val();
    }
</script>