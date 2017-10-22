<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <meta name="description" content="">
    <meta name="author" content="">
    <title>VDash Login</title>

    <!-- Bootstrap core CSS -->
    <link href="sbdash/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom fonts for this template -->
    <link href="sbdash/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- Custom styles for this template -->
    <link href="sbdash/css/sb-admin.css" rel="stylesheet">

  </head>

  <body class="bg-dark">

    <div class="container">

      <div class="card card-login mx-auto mt-5">
        <div class="card-header">
          Login
        </div>
        <div class="card-body">
          <form method="POST" action="${pageContext.request.contextPath}/login">
            <div class="form-group">	
              <label for="exampleInputEmail1">Email address</label>
              <input name="Email"  type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email">
            </div>
            <div class="form-group">
              <label for="exampleInputPassword1">Password</label>
              <input name="password"  type="password" class="form-control" id="exampleInputPassword1" placeholder="Password">
            </div>
            <div class="form-group">
              <div class="form-check">
<!--                 <label class="form-check-label">
                  <input type="checkbox" name="rememberMe" value= "Y" class="form-check-input">
                  Remember me
                </label> -->
                <p style="color: red;">${errorString}</p>
              </div>
            </div>
              <input type="submit" value="Login" class="btn btn-primary btn-block" /> 
              <!--  <a class="btn btn-primary btn-block" href="login">Login</a> -->
          </form>
          <div class="text-center">
            <a class="d-block small mt-3" href="register.html">Register an Account</a>
            <a class="d-block small" href="forgot-password.html">Forgot Password?</a>
          </div>
        </div>
      </div>
    </div>

    <!-- Bootstrap core JavaScript -->
    <script src="sbdash/vendor/jquery/jquery.min.js"></script>
    <script src="sbdash/vendor/popper/popper.min.js"></script>
    <script src="sbdash/vendor/bootstrap/js/bootstrap.min.js"></script>

  </body>

</html>