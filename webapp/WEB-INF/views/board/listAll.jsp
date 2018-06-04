<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>

<!-- content header (page header) -->
<section class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1 class="m-0 text-dark">Board List</h1>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="#">Home</a></li>
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
                            <tr>
                                <td>1.</td>
                                <td>Update software</td>
                                <td>
                                    <div class="progress progress-xs">
                                        <div class="progress-bar progress-bar-danger" style="width: 55%"></div>
                                    </div>
                                </td>
                                <td><span class="badge bg-danger">55%</span></td>
                            </tr>
                            <tr>
                                <td>2.</td>
                                <td>Clean database</td>
                                <td>
                                    <div class="progress progress-xs">
                                        <div class="progress-bar bg-warning" style="width: 70%"></div>
                                    </div>
                                </td>
                                <td><span class="badge bg-warning">70%</span></td>
                            </tr>
                            <tr>
                                <td>3.</td>
                                <td>Cron job running</td>
                                <td>
                                    <div class="progress progress-xs progress-striped active">
                                        <div class="progress-bar bg-primary" style="width: 30%"></div>
                                    </div>
                                </td>
                                <td><span class="badge bg-primary">30%</span></td>
                            </tr>
                            <tr>
                                <td>4.</td>
                                <td>Fix and squish bugs</td>
                                <td>
                                    <div class="progress progress-xs progress-striped active">
                                        <div class="progress-bar bg-success" style="width: 90%"></div>
                                    </div>
                                </td>
                                <td><span class="badge bg-success">90%</span></td>
                            </tr>
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

<%--suppress ES6ConvertVarToLetConst --%>
<%--TODO: 유효성 체크, 모달창 넣기 --%>
<script type="text/javascript">

    window.onload = function() {

        initPage();
        initEvent();
    };
    
    function initPage() {

        var result = $("#result").val();

        if (!result) { return; }

        if (result.toLowerCase() === "success") {
            alert("처리완료");
        }
    }

    function initEvent() {

        var $register = $("#register");

        $register.click(function () {
           location.href = "register";
        });
    }
</script>