<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- content header (page header) -->
<section class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1 class="m-0 text-dark">404 Error Page</h1>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="<c:url value="/" />">Home</a></li>
                    <li class="breadcrumb-item active">404 Error Page</li>
                </ol>
            </div>
        </div>
    </div>
</section>
<!-- // content-header -->

<!-- main content -->
<section class="content">
    <div class="error-page">
        <h2 class="headline text-warning"> 404</h2>

        <div class="error-content">
            <h3><i class="fa fa-warning text-warning"></i> Oops! Page not found.</h3>
            <p>
                We could not find the page you were looking for.
                Meanwhile, you may <a href="<c:url value="/" />">return to dashboard</a> or try using the search form.
            </p>
            <p class="font-weight-bold">
                ${exception.getMessage()}
            </p>
        </div>
    </div>
</section>
<!-- // main content -->