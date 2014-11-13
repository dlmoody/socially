 # Author: davidmoody 
 # CreateDate: 11/11/14
 # Purpose:
 #
 # History

 angular.module('socially').filter 'uninvited', () ->
  (users,party) ->
    return false unless party

    return _.filter users, (user) ->
      # console.log user
      not ( user._id is party.owner || _.contains party.invited, user._id )
