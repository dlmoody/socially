###
  Author: David Moody
  CreateDate: 11/11/2014
###



angular.module 'socially', ['angular-meteor', 'ui.router']



Meteor.startup(() ->
  angular.bootstrap document, ['socially']
)


Meteor.subscribe('users');




