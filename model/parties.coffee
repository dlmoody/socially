###
  Author: David Moody
  CreateDate: 11/11/2014
###


@Parties = new Mongo.Collection "parties"


allowMethods =
  insert: (userId, party) ->
    userId && party.owner is userId
  update: (userId, party, fields, modifier) ->
    userId is party.owner
  remove: (userId, party) ->
    userId is party.owner

Parties.allow allowMethods


Meteor.methods {
  invite: (partyId, userId) ->
    # debugger
    check partyId, String
    check userId, String
    party = Parties.findOne partyId
    throw new Meteor.Error(404, "No such Party") unless party
    throw new Meteor.Error(404, "No such Party") unless party.owner is this.userId
    throw new Meteor.Error(404, "The Party is PUBLIC no need to invite anyone") if party.isPublic

    if(userId isnt party.owner and not (_.contains(party.invited, userId)))
      Parties.update partyId, {$addToSet:{invited: userId}}

      partyOwner = Meteor.users.findOne(this.userId)
      invitee = Meteor.users.findOne(userId)

      from = contactEmail partyOwner
      to = contactEmail invitee

      if(Meteor.isServer and to)
        Email.send {
          from: "noreply@socially.com"
          to: to
          replyTo: from || undefined
          subject: "PARTY: " + party.name
          text: "Hey I just invited you to #{party.name} on Socially Come Check it out: #{Meteor.absoluteUrl()}"
        }

      return invitee
  rsvp: (partyId, rsvp) ->

    # input guard statements
    check(partyId, String)
    check(rsvp, String)

    # valid info guard statements
    throw new Meteor.Error 403, "You must be logged in to RSVP" unless this.userId
    throw new Meteor.Error 400, "Invalid RSVP" unless _.contains(['yes','no','maybe'], rsvp)

    # valid party guard
    party = Parties.findOne partyId
    throw new Meteor.Error 404, "No such Party" unless party


    rsvpIndex = _.indexOf _.pluck(party.rsvps, 'user'), this.userId

    if(rsvpIndex isnt -1)
      if(Meteor.isServer)
        Parties.update {_id: partyId, "rsvps.user": this.userId}, {$set:{"rsvps.$.rsvp": rsvp}}
      else
        modifier = {$set: {}}
        modifier.$set["rsvps." + rsvpIndex + ".rsvp"] = rsvp
        Parties.update partyId, modifier
    else
      Parties.update partyId, {$push: {rsvps: {user: this.userId, rsvp: rsvp}}}

  }

contactEmail = (user) ->
  return user.emails[0].address if user.emails and user.emails.length
  return user.services.facebook.email if user.services and user.services.facebook and user.services.facebook.email
  return null