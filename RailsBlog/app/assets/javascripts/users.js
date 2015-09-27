var apiToken = $('#api-token').val();
$.ajaxSetup({
    headers: {
        "token": apiToken
    }
});

var Post = Backbone.Model.extend({});
var PostCollection = Backbone.Collection.extend({
    model: Post,
    url: '/api/posts'
});

var PostView = Backbone.View.extend({
    tagName: 'li',
    className: 'post',
    template: _.template( $('#post-view').html() ),
    render: function(){
        this.$el.empty();
        var html = this.template( this.model.toJSON() );
        var $html = $(html);
        this.$el.append($html);

    },
    events:{
        'click button.remove': 'removePost'
    },
    removePost: function(){
        this.$el.remove();
        this.model.destroy();
    }
});

var PostListView = Backbone.View.extend({
    initialize: function(){
        this.listenTo(this.collection, 'add', this.render);
    },
    render: function(){
        this.$el.empty();
        var posts = this.collection.models;
        var view;
        for (var i = 0; i < posts.length; i++){
            view = new PostView({model: posts[i]});
            view.render();
            this.$el.append( view.$el );
        }
    }
});

var allThePosts = new PostCollection();
var postsPainter = new PostListView({
    collection: allThePosts,
    el: $('.posts')
});
allThePosts.fetch();

$('form.new-post').on('submit', function(e){
    e.preventDefault();
    var newName = $(this).find('input[name="post[name]"]').val();
    allThePosts.create({name: newName});
});
