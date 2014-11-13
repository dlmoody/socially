###
  Author: David Moody
  CreateDate: 11/11/2014
###


Meteor.startup(() ->
  if @Parties.find().count() is 0
    parties = [
      {name: 'Dubstep-Free Zone',description: 'Fast just got faster with Nexus S.'},
      {name: 'All dubstep all the time',description: 'Get it on!'},
      {name: 'Savage lounging',description: 'Leisure suit required. And only fiercest manners.'}
    ]

    @Parties.insert( party ) for party in parties
)