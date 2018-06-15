<%--suppress ELValidationInJSP ES6ConvertVarToLetConst --%>
<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">
    .popup { position: absolute; }
    .back { background-color: gray; opacity:0.5; width: 100%; height: 300%; overflow: hidden; z-index:1101; }
    .front { z-index: 1110; opacity: 1; border: 1px; margin: auto; }
</style>

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
                        <c:if test="${login.uid == boardVO.writer}">
                            <button type="button" class="btn btn-warning btn-sm" id="modify">Modify</button>
                            <button type="button" class="btn btn-danger btn-sm" id="remove">Remove</button>
                        </c:if>
                        <button type="button" class="btn btn-default btn-sm" id="list">List All</button>
                    </div>
                </div>
                <!-- // board form -->

                <!-- reply list -->
                <ul class="timeline">
                    <!-- timeline time label -->
                    <li class="time-label" id="repliesDiv"><span class="bg-info">Replies List <small class="replycnt">[${boardVO.replycnt}]</small></span></li>
                </ul>

                <div class="d-flex justify-content-center">
                    <ul id="pagination" class="pagination pagination-sm no-margin">
                    </ul>
                </div>
                <!-- // reply list -->

                <!-- reply form -->
                <c:if test="${not empty login}">
                    <div class="card card-outline">
                        <div class="card-header">
                            <h3 class="card-title">Add New Reply</h3>
                        </div>
                        <div class="card-body">
                            <div class="form-group">
                                <label for="replyer">Replyer</label>
                                <input type="text" class="form-control" id="replyer" name="replyer" value="${login.uid}" readonly/>
                            </div>
                            <div class="form-group">
                                <label for="replytext">Reply Text</label>
                                <input type="text" class="form-control" id="replytext" name="replytext" placeholder="Reply Text" />
                            </div>
                            <div class="card-footer bg-white">
                                <ul class="mailbox-attachments clearfix attachList">
                                </ul>
                            </div>
                        </div>
                        <div class="card-footer">
                            <button type="button" class="btn btn-warning btn-sm" id="reply">Add Reply</button>
                        </div>
                    </div>
                </c:if>
                <!-- // reply form -->

                <c:if test="${empty login}">
                    <div class="card card-outline">
                        <div><a href="<c:url value="/user/login" />">Login Please</a></div>
                    </div>
                </c:if>
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

<!-- Modal -->
<div id="modifyModal" class="modal modal-primary fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title"></h5>
                <button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
            </div>
            <div class="modal-body">
                <p><input type="text" class="form-control"></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-info btn-sm" id="replyModBtn">Modify</button>
                <button type="button" class="btn btn-danger btn-sm" id="replyDelBtn">Delete</button>
                <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<div class="popup back" style="display:none"></div>
<div id="popupFront" class="popup front" style="display:none">
    <img id="popupImg" src="" />
</div>

<script type="text/javascript">

    // TODO: 유효성체크, 댓글 목록 없을 시 처리, 게시글 삭제 시 댓글 삭제 처리, 뒤로가기 시 카운트 갱신 문제, 첨부파일 제대로 처리

    var $repliesDiv, bno, replyPage, replyListTemplate, paginationTemplate, fileListTemplate;

    window.onload = function() {

        initVars();
        initEventPage();
        initEventModal();
        initHandleBars();

        $.getJSON(gContextPath +"/board/getAttach/"+ bno, function(list) {

            $(list).each(function(){

                var fileInfo = getFileInfo(this);
                var html = fileListTemplate(fileInfo);

                $("ul.attachList").append(html);
            });
        });
    };

    function initVars() {

        bno = $("input[name=bno]").val();
        replyPage = 1;

        $repliesDiv = $("#repliesDiv");
    }

    function initEventPage() {

        var $form = $("#frmRead");

        $("#modify").click(function (evt) {

            evt.preventDefault();

            $form.attr("action", "modify");

            $form.submit();
        });

        $("#remove").click(function (evt) {

            evt.preventDefault();

            var replyCnt = Number($("small.replycnt").html().replace(/[\[\]]/g, ""));

            if(replyCnt > 0 ){
                alert("댓글이 달린 게시물을 삭제할 수 없습니다.");
                return;
            }

            var arr = [];

            $("ul.uploadedList li").each(function() {
                arr.push($(this).attr("data-src"));
            });

            if(arr.length > 0){
                $.post("/deleteAllFiles",{files: arr}, function(){

                });
            }

            $form.attr("action", "remove");
            $form.attr("method", "post");

            $form.submit();
        });

        $("#list").click(function () {

            $form.attr("action", "listAll");
            $form.submit();
        });

        // TODO: 버튼이 아닌 페이지 로딩 처리로 변경
        $repliesDiv.click(function() {
            getPage("/replies/" + bno + "/1");
        });

        $("#reply").click(function() {

            var replyer = $("#replyer").val(),
                replytext = $("#replytext").val();

            $.ajax({
                type: "post",
                url: gContextPath +"/replies/",
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

        $("ul.pagination").on("click", "li a", function(event) {

            event.preventDefault();

            replyPage = $(this).data("page");

            getPage("/replies/"+ bno +"/"+ replyPage);
        });

        $("ul.attachList").on("click", "div.mailbox-attachment-info a", function(event) {

            var fileLink = $(this).attr("href");

            if (checkImageType(fileLink)){

                event.preventDefault();

                var imgTag = $("#popupImg");
                imgTag.attr("src", fileLink);

                console.log(imgTag.attr("src"));

                $("div.popup").show("slow");
                imgTag.addClass("show");
            }
        });

        $("#popupImg").on("click", function(){
            $("div.popup").hide("slow");
        });
    }

    function initEventModal() {

        // 수정 modal 처리
        $("#modifyModal").on("show.bs.modal", function (evt) {

            var $this = $(this),
                $target = $(evt.relatedTarget),
                rno = $target.closest("li").data("rno"),
                text = $target.parent().siblings("div.timeline-body").text();

            $this.find("h5.modal-title").html(rno);
            $this.find("input[type=text]").val(text);
        });

        // 수정 처리
        $("#replyModBtn").click(function(evt) {

            var $modal = $(evt.target.offsetParent),
                rno = $modal.find("h5.modal-title").html(),
                text = $modal.find("input[type=text]").val();

            $.ajax({
                type: "put",
                url: gContextPath +"/replies/"+ rno,
                headers: {
                    "X-HTTP-Method-Override": "PUT"
                },
                contentType: "application/json",
                dataType: "text",
                data: JSON.stringify({ replytext:text }),
                success: function (result) {

                    console.log("result: " + result);

                    if (result === "success") {

                        alert("수정 되었습니다.");
                        getPage("/replies/"+ bno +"/"+ replyPage);
                    }
                }
            });
        });

        // 삭제 처리
        $("#replyDelBtn").click(function(evt) {

            var $modal = $(evt.target.offsetParent),
                rno = $modal.find("h5.modal-title").html();

            $.ajax({
                type: "delete",
                url: gContextPath +"/replies/"+ rno,
                headers: {
                    "X-HTTP-Method-Override": "DELETE"
                },
                contentType: "application/json",
                dataType: "text",
                success: function (result) {

                    console.log("result: " + result);

                    if (result === "success") {

                        alert("수정 되었습니다.");
                        getPage("/replies/"+ bno +"/"+ replyPage);
                    }
                }
            });
        });
    }

    function initHandleBars() {

        // 커스텀 함수 등록
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

        Handlebars.registerHelper("rownum", function(paging, idx) {

            var criteria = paging.criteria,
                rownum = paging.totalRowCount - ((criteria.page - 1) * criteria.perPageNum);

            return rownum - idx;
        });

        Handlebars.registerHelper("eqReplyer", function(replyer, block) {

            var accum = "";

            if (replyer === "${login.uid}") {
                accum += block.fn();
            }

            return accum;
        });

        // 템플릿 컴파일
        replyListTemplate = Handlebars.compile($("#replyList-template").html());
        paginationTemplate = Handlebars.compile($("#pagination-template").html());
        fileListTemplate = Handlebars.compile($("#fileList-template").html());
    }

    function getPage(url) {

        $.getJSON(gContextPath + url, function(data) {

            var list = data.list,
                paging = data.paging;

            if (list) {
                printData(list, paging);
                printPaging(paging);
            }

            $("#modifyModal").modal("hide");

            $("small.replycnt").html("["+ paging.totalRowCount +"]");
        });
    }

    function printData(replyList, paging) {

        var html = replyListTemplate({
            list: replyList,
            paging: paging
        });

        $("ul.timeline > li.replyLi").remove();
        $("#repliesDiv").after(html);
    }

    function printPaging(paging) {

        var html = paginationTemplate(paging);
        $("ul.pagination").html(html);
    }

    function zeroFill(number) {
        return ("0"+ number).slice(-2);
    }

    function getFileInfo(fullName){

        var fileName, imgSrc, getLink, fileLink;

        if(checkImageType(fullName)){
            imgSrc = gContextPath +"/board/displayFile?fileName="+ encodeURIComponent(fullName);
            fileLink = fullName.substr(14);

            var front = fullName.substr(0,12); // /2015/07/01/
            var end = fullName.substr(14);

            getLink = gContextPath +"/board/displayFile?fileName="+ front + end;

        }else{
            imgSrc ="/resources/dist/img/file.png";
            fileLink = fullName.substr(12);

            getLink = gContextPath +"/board/displayFile?fileName="+ encodeURIComponent(fullName);
        }

        fileName = fileLink.substr(fileLink.indexOf("_")+1);

        return {fileName: fileName, imgSrc: imgSrc, getLink: getLink, fullName: fullName};
    }

    function checkImageType(fileName) {

        var pattern = /jpg|gif|png|jpeg/i;
        return fileName.match(pattern);
    }
</script>

<!-- handlebars template -->
<script id="replyList-template" type="text/x-handlebars-template">
    {{#each list}}
        <li class="replyLi" data-rno={{rno}}>
            <i class="fa fa-comments bg-blue"></i>
            <div class="timeline-item">
            <span class="time">
            <i class="far fa-clock"></i>&nbsp;{{prettifyDate regdate}}
            </span>
                <h3 class="timeline-header"><strong>{{rownum ../paging @index}}</strong>&nbsp;-&nbsp;{{replyer}}</h3>
                <div class="timeline-body">{{replytext}}</div>
                <div class="timeline-footer">
                    {{#eqReplyer replyer}}
                        <a class="btn btn-default btn-sm" data-toggle="modal" data-target="#modifyModal">Modify</a>
                    {{/eqReplyer}}
                </div>
            </div>
        </li>
    {{/each}}
</script>

<script id="pagination-template" type="text/x-handlebars-template">
    {{#if showFirst}}
        <li class="page-item"><a class="page-link" href="#" data-page="1">처음</a></li>
    {{/if}}

    {{#if showPrevMore}}
        <li class="page-item"><a class="page-link" href="#" data-page="{{prevMorePage}}">&laquo;</a></li>
    {{/if}}

    {{#if showPrev}}
        <li class="page-item"><a class="page-link" href="#" data-page="{{prevPage}}">&lt;</a></li>
    {{/if}}

    {{#forPaging startPage endPage 1 selectPage}}
        <li class="page-item {{#equals this.index this.select 'active' ''}}{{/equals}}">
            <a class="page-link" href="#" data-page="{{this.index}}">{{this.index}}</a>
        </li>
    {{/forPaging}}

    {{#if showNext}}
        <li class="page-item"><a class="page-link" href="#" data-page="{{nextPage}}">&gt;</a></li>
    {{/if}}

    {{#if showNextMore}}
        <li class="page-item"><a class="page-link" href="#" data-page="{{nextMorePage}}">&raquo;</a></li>
    {{/if}}

    {{#if showLast}}
        <li class="page-item"><a class="page-link" href="#" data-page="{{totalPageCount}}">마지막</a></li>
    {{/if}}
</script>

<script id="fileList-template" type="text/x-handlebars-template">
    <li data-src="{{fullName}}">
        <span class="mailbox-attachment-icon has-img">&nbsp;<img src="{{imgSrc}}" alt="Attachment"></span>
        <div class="mailbox-attachment-info">
            <a href="{{getLink}}" class="mailbox-attachment-name"><i class="fas fa-camera"></i>&nbsp;{{fileName}}</a>
        </div>
    </li>
</script>