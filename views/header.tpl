<!DOCTYPE html>
<html>
<head>
    <title>Patrick's Blog</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="/static/style.css">
    <link rel="shortcut icon" type="image/x-icon" href="/static/favicon.ico"/>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
  <nav class="navbar navbar-expand-lg fixed-top bg-dark" style="font-weight:700;">
    <div class="container">
      <a class="navbar-brand" href="/">
        <h2 class="text-white">Patrick's Blog</h2>
      </a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNavDropdown">
        <ul class="navbar-nav">

        </ul>
        <ul class="navbar-nav ml-auto">
          % if defined('username'):
          <li class="nav-item"><a class="nav-link text-capitalize" href="/new/article"><i class="fas fa-plus"></i> New Article </a></li>
          <li class="nav-item"><a class="nav-link text-capitalize" href="#"><i class="far fa-user"></i> {{ username }} </a></li>
          <li class="nav-item"><a class="nav-link" href="/logout"><i class="fas fa-sign-out-alt"></i> Logout </a></li>
          % else:
          <li class="nav-item"><a class="nav-link" href="/login"><i class="fas fa-sign-in-alt"></i> Login </a></li>
          % end
        </ul>
      </div>
      </div>

  </nav>
