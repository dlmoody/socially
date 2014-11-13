###
  Author: David Moody
  CreateDate: 11/11/2014
###

angular.module('socially').config(['$urlRouterProvider', '$stateProvider', '$locationProvider',
 ($urlRouterProvider, $stateProvider, $locationProvider) ->
  $locationProvider.html5Mode(true)

  $stateProvider
  .state('parties', {
     url:'/parties',
     template: UiRouter.template('parties-list.html'),
     controller: 'PartiesListCtrl'
    })
  .state('partyDetails', {
     url: '/parties/:partyId',
     template: UiRouter.template('party-details.html')
     controller: 'PartyDetailsCtrl'
    });

  $urlRouterProvider.otherwise '/parties'

])