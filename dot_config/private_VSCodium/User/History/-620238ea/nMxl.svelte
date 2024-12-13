<div style="max-width: 80ch; margin: auto;">
  <p>
    <h1>Data Analysis</h1>
    - Analyse existing data to identify patterns and preferences for each user, based
    on visit frequency and duration, and interaction types<br />
    - Look for patterns for each user such as which genres, artists, and artist groups
    they liked<br />
    - Create profiles for each user, and use this to group them for recommendations
    (likely multiple groups per user)<br />
    - Recommend liked songs and artists to other users in the same groups on user's
    home and search pages<br />
    - Use the same profile data to discover which artists are similar to eachother
    and recommend related artists on artist pages<br />
    <br />
    <h1>Implementation</h1>
    - Create three new database tables for user profile groups, artist profile groups,
    and group affiliations<br />
    - Use an interaction scoring system similar to task 2 to determine user preferences
    <br />
    - Generate user and artist groups by finding the top combinations of artists,
    possibly assigning them weights to fine tune groupings<br />
    - Add a user to a group when they are affiliated with enough of the artists in
    that group (beyond a certain threshold of number of artists or interaction points)
    <br />

    - Run this analysis on a schedule, possibly running the group generation
    less frequently as it would be slow<br />
  </p>
  <br />

  <p>
    <h1>Note</h1>
    - This analysis was done without access to anythong other than the database,
    so it's possible these features would already exist or there may be a need for
    more useful features I'm unaware of<br />
    - Since the mock data is all random, I elected not to try and find patterns in
    it, so I haven't included any actual analysis here<br />
    - Tailwind removes formatting on headings, tables, links and probably more, and
    their docs are behind a paywall otherwise I'd use Markdown and a preprocessor
    like svelte-markdown, or at least have some formatting, sorry :P
  </p>
</div>
