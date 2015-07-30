// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//= require underscore
//= require angular
//= require angular-locale_ru-ru
//= require angular-route
//= require angular-animate
//= require angular-resource
//= require angular-notify

//= require js-routes

//= require_self
//= require_tree .


var app = angular.module('app', ['ngRoute', 'ngAnimate', 'ngResource', 'ngNotify']);


app.run(['$rootScope', 'Search', 'Product', 'Sign', function ($rootScope, Search, Product, Sign) {
  $rootScope.categories = gon.categories;
  $rootScope.Search = Search;
  $rootScope.Product = Product;
  $rootScope.Sign = Sign;

  Product.updateCart();
}])