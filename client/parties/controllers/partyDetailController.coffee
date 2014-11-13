###
  Author: David Moody
  CreateDate: 11/11/2014
###


angular.module('socially').controller('PartyDetailsCtrl', ['$scope', '$stateParams', '$collection', '$methods'
 ($scope, $stateParams, $collection, $methods) ->

  ###
   using the $collection and the bindOne function see http://angularjs.meteor.com/api
  ###
  $collection(Parties).bindOne $scope, 'party', $stateParams.partyId, true, true

  $collection(Meteor.users).bind $scope, 'users', false, true

  $scope.canInvite = () ->
    console.log $scope.party.isPublic
    console.log $scope.party.owner
    console.log Meteor.userId()
    return false unless $scope.party
    return $scope.party.isPublic is false and ($scope.party.owner is Meteor.userId())


  $scope.invite = (user) ->
   $methods.call('invite', $scope.party._id, user._id)
     .then((data) ->
       console.log 'success inviting', data
     (err) ->
       console.log 'failed', err)

])