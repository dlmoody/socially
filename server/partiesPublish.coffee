###
  davidmoody
 11/11/14
###




###

  find = $or: [
        $and:[
         "public": true
         "public": $exists: true
        ]
        $and:[
         owner: this.userId
         owner: $exists: true
        ]
       ]

Meteor.publish 'parties', () ->
 Parties.find  $or: [
        $and:[
         "public": true
         "public": $exists: true
        ]
        $and:[
         owner: this.userId
         owner: $exists: true
        ]
       ]

###


Meteor.publish 'parties', () ->
  Parties.find  $or: [
    {$and:[
      {"public": true}
      {"public": {$exists: true}}
    ]}
    {$and:[
      {owner: this.userId}
      {owner: $exists: true}
    ]},
    {$and:[
      {invited: this.userId},
      {invited: {$exists: true}}
    ]}
  ]