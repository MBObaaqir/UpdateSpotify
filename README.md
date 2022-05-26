# Update Spotify
Ruby script for updating a "Spotify" JSON object based on a changes file

This script ingests an input JSON object through and input JSON file, applies
changes to it based on a changes text file and writes the updated JSON object
to an output JSON file.

Interact with the application like this:

`$ ruby UpdateSpotify.rb <input-file> <changes-file> <output-file>`

For example:

`$ ruby UpdateSpotify.rb spotify.json changes.txt output.json`

The input file must not have duplicate IDs for data entries (Users, Songs etc)

In the interest of time and keeping things simple I only implemented the basic
features outlined in the description of the exercise, and didn't commit time
for much standardization. I spent little over 2 hours on the project from start to finish

I included an example folder with a set of input,
changes and output file and used that to test the application with

`$ ruby UpdateSpotify.rb example/spotify.json example/changes.txt example/output.json`

If the application needed to be scaled we would have to ensure there is enough
RAM to handle the input and changes files. We would also have to implement
complex tests to thoroughly test the expanded functionality that would need
to be implemented.
