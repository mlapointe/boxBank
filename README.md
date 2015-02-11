# boxBank
Box API example - Bank of America loan application

Sinatra modular app.

##To Run
`$ bundle install` 
`$ rackup `

Point browser to: `http://localhost:9292`

##Notes

###Ideal App
This app is near finished for a demo. If given more time, these are the things I would do:
- Add local DB -> Allow server to track submissions including: name, email, status, Box View API Document ID, app folder_ids
- Finish Box View API implementation (see below)
- Implement file comments
- Deploy to Heroku

### Box View API
Ideally, I would have liked to fully implement the Box View API in order to allow documents to be shown to the user/banker while using the app. Please see `review.js` and `review_controller.rb` for sample source code. 

This section was not completed because of how the Box View API works -- documents are first queued to be transferred to HTML, and thus I could not submit a document for processing and subsequently retrieve it for rendering via `viewer.js` in time for an uninterrupted user experience. With a database locally, files could be sent to the Box View API on application submission, the document_id could be stored for that submission in the DB and then retrieved later for a Box View API session on call.

Additional consideration >> unsure wether or not the Box View API is secure enough for a Bank application - may not be the best implementation in this case if not - especially since it doesn't require oauth 2.
