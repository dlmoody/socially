#
# Author: David Moody
# CreateDate: 11/11/2014
# Purpose:



angular.module('socially').controller('PartiesListCtrl', ['$scope', '$collection','$rootScope', '$methods'
 ($scope, $collection, $rootScope, $methods) ->


  $scope.newParty = {}
  $scope.newParty.isPublic = false

  $collection(Parties).bind $scope, 'parties', true, true

  $collection(Meteor.users).bind($scope, 'users', false, true);

  # removes one item from the parties array
  $scope.remove = (party) ->
   $scope.parties.splice $scope.parties.indexOf(party), 1


  # initial order
  $scope.orderProperty = 'name';

  $scope.add = (party) ->
   #console.log $rootScope.currentUser._id
   $scope.newParty.owner = $rootScope.currentUser._id;
   $scope.newParty.invited = []
   #console.log $scope.newParty
   $scope.parties.push($scope.newParty)
   $scope.newParty = {}

  $scope.getUserById = (userId) ->
   #console.log userId
   Meteor.users.findOne userId

  $scope.creator = (party) ->
   return unless party
   owner = $scope.getUserById party.owner

   return 'nobody' unless owner

   if $rootScope.currentUser and $rootScope.currentUser._id and (owner._id is $rootScope.currentUser._id)
    return 'me'

   return owner


  $scope.rsvp = (partyId, rsvp) ->
    $methods.call('rsvp', partyId, rsvp)
      .then((data) ->
        console.log 'success responding',data
      (err) ->
        console.log 'failed', err)


  $scope.outstandingInvitations = (party) ->
    return _.filter($scope.users, (user) ->
      return (_.contains(party.invited, user._id) and not _.findWhere(party.rsvps,{user:user._id}))
    )

])