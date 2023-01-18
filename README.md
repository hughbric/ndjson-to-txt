# Convert Sanity's `.ndjson` to text file

Sanity exports data as [Newline Delimited JSON](http://ndjson.org/). This is not readable, particularly when wanting to export and archive blog posts that need to be in a usable format for reference.

This script takes Sanity's `data.ndjson` file and outputs a formatted `.txt` file.

At the end/bottom of the `output.txt` file there will be an index of all the blogs contained in the file, along with a list of their titles.

## How to use

You will need `ruby` already installed which I recommend installing through [rvm](https://rvm.io/rvm/install). Follow the CLI prompts if a failure occurs in the process.

Clone this repo and then run `bundle install` from the command line.

The script takes one argument which is the file path of the data to be converted. It must have a `.ndjson` file extension.

See the [Sanity documentation](https://www.sanity.io/docs/migrating-data#f08709f5ee1a) for how to export and obtain this file, from the `studio` folder try:  
`sanity dataset export production ./production.tar.gz --no-drafts --types post,author,tag,category`

Place the `data.ndjson` file in the root of this project folder.

To run the script:  
`./ndjson-to-txt.rb ./data.ndjson`

The permissions for this file should allow it to be run as an executable, if not, try:  
`ruby ./ndjson-to-txt.rb ./data.ndjson`

The file will write to the empty `./output.txt` in this repo.

## To run the tests

From the project root run: `rspec`
