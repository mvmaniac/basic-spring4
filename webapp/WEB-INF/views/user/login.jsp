<%--suppress ES6ConvertVarToLetConst --%>
<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core_1_1" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="tilesx" uri="http://tiles.apache.org/tags-tiles-extras" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />

    <title><tiles:getAsString name="title" /></title>

    <link type="text/css" rel="stylesheet" href="<c:url value="/css/fontawesome/5.0.13/fa-svg-with-js.css" />" />
    <link type="text/css" rel="stylesheet" href="<c:url value="/css/bootstrap/4.1.1/bootstrap.css" />" />
    <link type="text/css" rel="stylesheet" href="<c:url value="/css/adminlte/3.0.0-alpha2/adminlte.min.css" />" />
</head>
<body class="hold-transition login-page">

    <div class="login-box">
        <div class="login-logo">
            <a href="<c:url value="/" />"><b>Admin</b>LTE</a>
        </div>

        <div class="card">
            <div class="card-body login-card-body">
                <p class="login-box-msg">Sign in to start your session</p>

                <form action="<c:url value="/user/loginPost" />" method="post">
                    <div class="form-group has-feedback">
                        <input type="text" name="uid" class="form-control" placeholder="USER ID">
                    </div>
                    <div class="form-group has-feedback">
                        <input type="password" name="upw" class="form-control" placeholder="Password">
                    </div>
                    <div class="row">
                        <div class="col-8">
                            <div class="checkbox icheck">
                                <label>
                                    <input type="checkbox" name="useCookie"> Remember Me
                                </label>
                            </div>
                        </div>
                        <div class="col-4">
                            <button type="submit" class="btn btn-primary btn-block btn-flat">Sign In</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="<c:url value="/js/fontawesome/5.0.13/fontawesome-all.min.js" />"></script>
    <script src="<c:url value="/js/jquery/3.3.1/jquery.min.js" />"></script>
    <script src="<c:url value="/js/bootstrap/4.1.1/bootstrap.min.js" />"></script>
    <script src="<c:url value="/js/adminlte/3.0.0-alpha2/adminlte.min.js" />"></script>

    <script type="text/javascript">
        $(function () {
            $("input").iCheck({
                checkboxClass: "icheckbox_square-blue",
                radioClass   : "iradio_square-blue",
                increaseArea : "20%" // optional
            });
        })
    </script>
</body>
</html>