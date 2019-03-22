% include("./views/header.tpl")

<div class="container">
  <div class="row">
    <div class="col-sm-12" style="margin-bottom:25px;">
      <h3> {{article.title}} </h3>
      <p>By: {{ article.author }}</p>
      <div>
        {{article.body}}
      </div>

    </div>
  </div>

</div>
% include("./views/footer.tpl")
