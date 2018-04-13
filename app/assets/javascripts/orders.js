document.addEventListener("DOMContentLoaded", function(event) {
  var $orders = document.getElementById('orders');
  if (!$orders) { return; }
  var orders = new Vue({
    el: '#orders',
    data: {
      orders: [],
      movies: [],
      reverse: 1,
      selectedDay: '',
      selectedMovie: ''
    },
    mounted: function() {
      Rails.ajax({
        type: 'GET',
        url: '/orders.json',
        success: function(data) {
          this.orders = data;
          this.movies = _.chain(this.orders)
            .map('movie.title')
            .uniq()
            .value();
        }.bind(this),
        error: function(err) { console.log(err); }
      });
    },
    methods: {
      prettyDate: function(date) {
        return moment(date).format('MMM Do YYYY, h:mm a');
      },
      sortAscDec: function(col) {
        var direction = this.reverse === -1 ? 'asc' : 'desc';
        this.reverse *= -1;
        this.orders = _.orderBy(this.orders, col, [direction]);
      }
    },
    computed: {
      filteredOrders: function() {
        var that = this;
        if(!this.selectedDay && !this.selectedMovie) { return this.orders; }
        return this.orders.filter(function(order) {
          var day = that.selectedDay ? moment(order.showtime.time).format('dddd') === that.selectedDay : true;
          var movie = that.selectedMovie ? order.movie.title === that.selectedMovie : true;
          return day && movie;
        });
      },
      totalRevenue: function() {
        return this.filteredOrders.map(function(order){
          return order.quantity * order.showtime.price;
        }).reduce(function(a,b){
          return a + b;
        },0);
      },
      totalQuantity: function() {
        return this.filteredOrders.map(function(order){
          return order.quantity;
        }).reduce(function(a,b){
          return a + b;
        },0);
      },
      mostPopularMovie: function() {
        if(!this.filteredOrders.length) { return {movie:'', quantity: ''}; }
        var movieObj = {};
        this.filteredOrders.forEach(function(order){
          if(movieObj[order.movie.title]){
            movieObj[order.movie.title] = movieObj[order.movie.title] + order.quantity;
          } else {
            movieObj[order.movie.title] = order.quantity;
          }
        });
        var moviesArray = [],
          item;
        for (var movie in movieObj) {
          item = {};
          item.movie = movie;
          item.quantity = movieObj[movie];
          moviesArray.push(item);
        }
        return _.chain(moviesArray)
          .orderBy('quantity', 'desc')
          .head()
          .value();
      }
    },
  });
});
