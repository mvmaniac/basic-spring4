<%--suppress ES6ConvertVarToLetConst --%>
<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- content header (page header) -->
<section class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1 class="m-0 text-dark">Read Board</h1>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="<c:url value="/" />">Home</a></li>
                    <li class="breadcrumb-item active">Read Board</li>
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
                        <h3 class="card-title">Board Content</h3>
                    </div>
                    <div class="card-body">
                        <div class="form-group">
                            <label for="title">Title</label>
                            <input type="text" class="form-control" id="title" name="title" value="${boardVO.title}" readonly />
                        </div>
                        <div class="form-group">
                            <label for="content">Content</label>
                            <textarea class="form-control" rows="3" id="content" name="content" readonly>${boardVO.content}</textarea>
                        </div>
                        <div class="form-group">
                            <label for="writer">Writer</label>
                            <input type="text" class="form-control" id="writer" name="writer" value="${boardVO.writer}" readonly />
                        </div>
                    </div>
                    <div class="card-footer">
                        <button type="button" class="btn btn-warning btn-sm" id="modify">Modify</button>
                        <button type="button" class="btn btn-danger btn-sm" id="remove">Remove</button>
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

<form role="form" id="frmRead">
    <input type="hidden" name="bno" value="${boardVO.bno}" />
    <input type="hidden" name="page" value="${cri.page}" />
    <input type="hidden" name="perPageNum" value="${cri.perPageNum}" />
    <input type="hidden" name="searchType" value="${cri.searchType}" />
    <input type="hidden" name="keyword" value="${cri.keyword}" />
</form>

<script type="text/javascript">

    window.onload = function() {

        initPage();
        initEvent();
    };

    function initPage() {}

    function initEvent() {

        var $form = $("#frmRead"),
            $modify = $("#modify"),
            $remove = $("#remove"),
            $list = $("#list");

        // TODO: 유효성 체크
        $modify.click(function (evt) {

            evt.preventDefault();

            $form.attr("action", "modify");

            $form.submit();
        });

        $remove.click(function (evt) {

            evt.preventDefault();

            $form.attr("action", "remove");
            $form.attr("method", "post");

            $form.submit();
        });

        $list.click(function () {

            $form.attr("action", "listAll");
            $form.submit();
        });
    }
</script>