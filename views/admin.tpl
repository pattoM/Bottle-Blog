% include("./views/header.tpl")

<div class="container">
  <div class="row">
    <div class="col-sm-12" style="margin-bottom:25px;">
      <h3 class="text-center"> Add new writer</h3>
      <form action="/add_writer" method="post">
        <div class="form-group">
          <label for="writer-name">Name</label>
          <input type="text" class="form-control" id="writer-name" name='name'>
        </div>
        <div class="form-group">
          <label for="username">Username</label>
          <input type="text" class="form-control" id="username" name='username'>
        </div>
        <div class="form-group">
          <label for="password">Password</label>
          <input type="password" class="form-control" id="password" name='password'>
        </div>
        <button type="submit" class="btn btn-primary btn-sm">Create Writer</button>
      </form>
    </div>
  </div>

</div>
% include("./views/footer.tpl")
