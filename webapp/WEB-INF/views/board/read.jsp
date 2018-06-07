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

                <!-- board form -->
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
                <!-- // board form -->

                <!-- reply list -->
                <ul class="timeline">
                    <!-- timeline time label -->
                    <li class="time-label" id="repliesDiv"><span class="bg-info">Replies List</span></li>
                </ul>

                <div class="d-flex justify-content-center">
                    <ul id="pagination" class="pagination pagination-sm no-margin">
                    </ul>
                </div>
                <!-- // reply list -->

                <!-- reply form -->
                <div class="card card-outline">
                    <div class="card-header">
                        <h3 class="card-title">Add New Reply</h3>
                    </div>
                    <div class="card-body">
                        <div class="form-group">
                            <label for="replyer">Replyer</label>
                            <input type="text" class="form-control" id="replyer" name="replyer" placeholder="Replyer" />
                        </div>
                        <div class="form-group">
                            <label for="replytext">Reply Text</label>
                            <input type="text" class="form-control" id="replytext" name="replytext" placeholder="Reply Text" />
                        </div>
                    </div>
                    <div class="card-footer">
                        <button type="button" class="btn btn-warning btn-sm" id="reply">Add Reply</button>
                    </div>
                </div>
                <!-- // reply form -->

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

    var $repliesDiv, bno, replyListTemplate, paginationTemplate;

    window.onload = function() {

        initPage();
        initEvent();
        initHandleBars();
    };

    function initPage() {
        bno = $("input[name=bno]").val();
        $repliesDiv = $("#repliesDiv");
    }

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

        $repliesDiv.click(function() {
            getPage("/replies/" + bno + "/1");
        });

        $("#reply").click(function() {

            var replyer = $("#replyer").val(),
                replytext = $("#replytext").val();

            $.ajax({
                type:"post",
                url: contextPath +"/replies/",
                headers: {
                    "X-HTTP-Method-Override": "POST"
                },
                contentType: "application/json",
                dataType: "text",
                data: JSON.stringify({ bno:bno, replyer:replyer, replytext:replytext }),
                success: function (result) {

                    console.log("result: " + result);

                    if (result === "success") {

                        alert("등록 되었습니다.");

                        getPage("/replies/"+ bno +"/1");

                        $("#replyer").val("");
                        $("#replytext").val("");
                    }
                }
            });
        });

        $("ul.pagination").on("click", "li a", function(event){

            event.preventDefault();

            var replyPage = $(this).data("page");
            getPage("/replies/"+ bno +"/"+ replyPage);
        });
    }

    function initHandleBars() {

        replyListTemplate = Handlebars.compile($("#replyList-template").html());
        paginationTemplate = Handlebars.compile($("#pagination-template").html());

        Handlebars.registerHelper("prettifyDate", function(timeValue) {

            var dateObj = new Date(timeValue),
                year = dateObj.getFullYear(),
                month = zeroFill(dateObj.getMonth() + 1),
                date = zeroFill(dateObj.getDate()),
                hour = zeroFill(dateObj.getHours()),
                minute = zeroFill(dateObj.getMinutes()),
                second = zeroFill(dateObj.getSeconds());

            return year + "/" + month + "/" + date +" "+ hour +":"+ minute +":"+ second;
        });

        Handlebars.registerHelper("forPaging", function(start, end, step, select, block) {

            var html = "";

            for(var i = start; i <= end; i += step) {
                html += block.fn({
                    index: i,
                    select: select
                });
            }

            return html;
        });

        Handlebars.registerHelper("equals", function(v1, v2, yes, no) {
            return (v1 === v2) ? yes : no;
        });
    }

    function getPage(url) {

        $.getJSON(contextPath + url, function(data) {

            var list = data.list,
                paging = data.paging;

            if (list) {
                printData(list);
                printPaging(paging);
            }
            //$("#modifyModal").modal("hide");
        });
    }

    function printData(replyList) {

        var html = replyListTemplate(replyList);

        $("ul.timeline > li.replyLi").remove();
        $("#repliesDiv").after(html);
    }

    var printPaging = function(paging) {

        var html = paginationTemplate(paging);
        $("ul.pagination").html(html);
    };

    function zeroFill(number) {
        return ("0"+ number).slice(-2);
    }
</script>