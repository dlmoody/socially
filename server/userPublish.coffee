###
  davidmoody
 11/11/14
###


Meteor.publish 'users', () ->
 Meteor.users.find {}, {fields:{emails: 1, profile: 1}}