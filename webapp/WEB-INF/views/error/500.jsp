<%--suppress ELValidationInJSP --%>
<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- content header (page header) -->
<section class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1 class="m-0 text-dark">500 Error Page</h1>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="<c:url value="/" />">Home</a></li>
                    <li class="breadcrumb-item active">500 Error Page</li>
                </ol>
            </div>
        </div>
    </div>
</section>
<!-- // content-header -->

<!-- main content -->
<section class="content">
    <div class="error-page">
        <h2 class="headline text-danger">500</h2>
        <div class="error-content">
            <h3><i class="fa fa-warning text-danger"></i> Oops! Something went wrong.</h3>
            <p>
                We will work on fixing that right away.
                Meanwhile, you may <a href="<c:url value="/" />">return to Home</a> or try using the search form.

            </p>
            <p class="font-weight-bold">
                ${exception.getMessage()}
            </p>
        </div>
    </div>
</section>
<!-- // main content -->