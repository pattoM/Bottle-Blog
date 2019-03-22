% include("./views/header.tpl")

<div class="container">
  <div class="row">
    % for article in articles:
    <div class="col-sm-12" style="margin-bottom:25px;">
      <div class="card">
        <div class="card-header font-weight-bold">{{ article['title'] }}</div>
        <div class="card-body">
          {{ article['body'][:150] }} ...
          <br/><br/>
          <a href="/view/article/{{article['id']}}">Read More >> </a>
        </div>
        <div class="card-footer">Author: {{ article['author'] }}</div>
      </div>
    </div>
    % end
  </div>

</div>
% include("./views/footer.tpl")
