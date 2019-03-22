% include("./views/header.tpl")

<div class="container">
  <div class="row">
    <div class="col-sm-12">
      <h1 class="text-center"> New Article  </h1>
      <form action="/new/article" method="post">
        <div class="form-group">
          <label for="article-title">Title</label>
          <input type="text" class="form-control" id="article-title" name='title'>
        </div>
        <div class="form-group">
          <label for="article-body">Body</label>
          <textarea name="body" class="form-control" rows="5" id="article-body"></textarea>
        </div>
        <button type="submit" class="btn btn-primary btn-sm">Add</button>&emsp;<a href="/"><button type="button" class="btn btn-secondary btn-sm">Cancel</button></a>
      </form>

    </div>
  </div>

</div>
% include("./views/footer.tpl")
