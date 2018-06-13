<%--suppress ELValidationInJSP ES6ConvertVarToLetConst --%>
<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">
    .fileDrop {
        width: 80%;
        height: 100px;
        border: 1px dotted gray;
        background-color: lightslategrey;
        margin: auto;

    }
</style>

<!-- content header (page header) -->
<section class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1 class="m-0 text-dark">Board Register</h1>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="<c:url value="/" />">Home</a></li>
                    <li class="breadcrumb-item active">Board Register</li>
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
                        <h3 class="card-title">Register Form</h3>
                    </div>
                    <div class="card-body">
                        <form role="form" method="post" id="frmRegister">
                            <div class="form-group">
                                <label for="title">Title</label>
                                <input type="text" class="form-control" id="title" name="title" placeholder="Enter Title" />
                            </div>
                            <div class="form-group">
                                <label for="content">Content</label>
                                <textarea class="form-control" rows="3" id="content" name="content" placeholder="Enter ..."></textarea>
                            </div>
                            <div class="form-group">
                                <label for="writer">Writer</label>
                                <input type="text" class="form-control" id="writer" name="writer" placeholder="Enter Write" />
                            </div>
                            <div class="form-group">
                                <label for="files">File DROP Here</label>
                                <div class="fileDrop" id="files"></div>
                            </div>
                            <div class="card-footer bg-white">
                                <ul class="mailbox-attachments clearfix attachList">
                                </ul>
                            </div>
                        </form>
                    </div>
                    <div class="card-footer">
                        <button type="button" class="btn btn-primary btn-sm" id="save">Save</button>
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

<form role="form" id="frmList">
    <input type="hidden" name="page" value="${cri.page}" />
    <input type="hidden" name="perPageNum" value="${cri.perPageNum}" />
    <input type="hidden" name="searchType" value="${cri.searchType}" />
    <input type="hidden" name="keyword" value="${cri.keyword}" />
</form>

<script type="text/javascript">

    var fileListTemplate;

    window.onload = function() {

        initVars();
        initEventPage();
        initHandleBars();
    };

    function initVars() {}

    function initEventPage() {

        var $frmRegister = $("#frmRegister"),
            $frmList = $("#frmList"),
            $save = $("#save"),
            $list = $("#list"),
            $fileDrop = $("div.fileDrop");

        // TODO: 유효성 체크
        $save.click(function (evt) {

            evt.preventDefault();

            var str ="";

            $("ul.attachList .delete").each(function (index) {
                str += "<input type='hidden' name='files["+ index +"]' value='"+ $(this).attr("href") +"'>";
            });

            $frmRegister.append(str);
            $frmRegister.submit();
        });

        $list.click(function () {

            $frmList.attr("action", gContextPath +"/board/listAll");
            $frmList.submit();
        });

        $fileDrop.on("dragenter dragover", function(event) {
            event.preventDefault();
        });

        $fileDrop.on("drop", function(event){

            event.preventDefault();

            var files = event.originalEvent.dataTransfer.files;
            var file = files[0];

            console.log(file);

            var formData = new FormData();
            formData.append("file", file);

            $.ajax({
                url: gContextPath +"/board/uploadAjax",
                type: "POST",
                data: formData,
                dataType:"text",
                processData: false,
                contentType: false,
                success: function (data) {

                    var fileInfo = getFileInfo(data);
                    var html = fileListTemplate(fileInfo);

                    $("ul.attachList").append(html);
                }
            });
        });
    }

    function initHandleBars() {

        // 템플릿 컴파일
        fileListTemplate = Handlebars.compile($("#fileList-template").html());
    }

    function checkImageType(fileName) {

        var pattern = /jpg|gif|png|jpeg/i;
        return fileName.match(pattern);
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
</script>

<script id="fileList-template" type="text/x-handlebars-template">
    <li>
        <span class="mailbox-attachment-icon has-img"><img src="{{imgSrc}}" alt="Attachment"></span>
        <div class="mailbox-attachment-info">
            <a href="#" class="mailbox-attachment-name"><i class="fas fa-camera"></i>&nbsp;{{fileName}}</a>
            <%--<span class="mailbox-attachment-size">2.67 MB--%>
                <%--<a href="{{getLink}}" class="btn btn-default btn-sm float-right download"><i class="fas fa-cloud-download-alt"></i></a>--%>
                <%--<a href="{{fullName}}" class="btn btn-default btn-sm float-right delete"><i class="fas fa-trash-alt"></i></a>--%>
            <%--</span>--%>
        </div>
    </li>
</script>
