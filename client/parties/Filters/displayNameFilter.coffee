 # Author: davidmoody 
 # CreateDate: 11/11/14
 # Purpose:
 #
 # History

 angular.module('socially').filter 'displayName', () ->
  (user) ->
   # console.log 'user', user
   return unless user
   return user.profile.name if(user.profile && user.profile.name)
   return user.emails[0].address if (user.emails)
   return user
