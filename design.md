# Makers BnB design

### Headline specs

- Any signed-up user can list a new space.
- Users can list multiple spaces.
- Users should be able to name their space, provide a short description of the space, and a price per night.
- Users should be able to offer a range of dates where their space is available.
- Any signed-up user can request to hire any space for one night, and this should be approved by the user that owns that space.
- Nights for which a space has already been booked should not be available for users to book that space.
- Until a user has confirmed a booking request, that space can still be booked for that night.

See lower down for 'nice to haves'.

### User story

> As a [user], I want to be able to [sign_in].       
> As a user, I want to be able to list a [new_space].        
> As a user, I want to be able to list {mulitple_spaces}.        
> As a user, I want to be able to [name] {a space}.        
> As a user, I want to be able to provide a short [description] of a space.        
> As a user, I want to be able to provide a [price] per night.        
> As a user, I want to be able to offer a range of [dates] where the space is a [available].        
> As a user, I want to be able to request to [hire] a space for {one night}.        
> As a user, I want my hire request {approved} by the owner user.        
> As a user, I want my hired space to show as {unavailable} for dates when a hire has been {approved}.        
> As a user, I want my hired space to show as {available} {until} a hire request has been {approved}.        

### Nice to have specs

- Users should receive an email whenever one of the following happens:
 - They sign up
 - They create a space
 - They update a space
 - A user requests to book their space
 - They confirm a request
 - They request to book a space
 - Their request to book a space is confirmed
 - Their request to book a space is denied
- Users should receive a text message to a provided number whenever one of the following happens:
 - A user requests to book their space
 - Their request to book a space is confirmed
 - Their request to book a space is denied
- A ‘chat’ functionality once a space has been booked, allowing users whose space-booking request has been confirmed to chat with the user that owns that space
- Basic payment implementation though Stripe.