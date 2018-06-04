`<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>

<!-- content header (page header) -->
<section class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1 class="m-0 text-dark">Board Register</h1>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="#">Home</a></li>
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
                    <form role="form" method="post">
                        <div class="card-body">
                            <div class="form-group">
                                <label for="title">Title</label>
                                <input type="text" class="form-control" id="title" name="title" placeholder="Enter Title">
                            </div>
                            <div class="form-group">
                                <label>Content</label>
                                <textarea class="form-control" rows="3" id="content" name="content" placeholder="Enter ..."></textarea>
                            </div>
                            <div class="form-group">
                                <label for="writer">Writer</label>
                                <input type="text" class="form-control" id="writer" name="writer" placeholder="Enter Write">
                            </div>
                        </div>
                        <div class="card-footer">
                            <button type="submit" class="btn btn-primary btn-sm">Submit</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- // row -->
    </div>
    <!-- // container-fluid -->
</section>
<!-- // main content -->