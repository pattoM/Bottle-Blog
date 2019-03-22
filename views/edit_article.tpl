% include("./views/header.tpl")
<div class="container">
  <div class="row">
    <div class="col-sm-12">
      <h1 class="text-center"> Edit article  </h1>
      <form action="/edit/article/{{article.id}}" method="post">
        <div class="form-group">
          <label for="article-title">Title</label>
          <input type="text" class="form-control" id="article-title" name='title' value="{{article.title}}">
        </div>
        <div class="form-group">
          <label for="article-body">Body</label>
          <textarea name="body" class="form-control" rows="5" id="article-body">{{article.body}}</textarea>
        </div>
        <button type="submit" class="btn btn-primary btn-sm">Save changes</button>&emsp;<a href="/"><button type="button" class="btn btn-secondary btn-sm">Cancel</button></a>
      </form>

    </div>
  </div>

</div>

% include("./views/footer.tpl")
