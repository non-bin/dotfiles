<!-- # **Task 3: Creative ways to enhance user experience**

### **Description:**

Based on the trends and data available, write down some dot points on how you would improve the way users discover new artists.

### **Requirements (to think about):**

- **Data Analysis**:
    - Think about how you would analyse the existing interaction data to identify patterns and preferences for each user.
    - Consider factors such as the frequency of visits, interaction types (e.g., likes, shares), and the duration of interactions.

### **Implementation Plan**

- Provide a high-level plan for how you would implement the recommendation system in the existing codebase.
- Discuss any potential challenges and how you would address them.
- **Note:** You are **not required to write any code** for this task. Instead, focus on explaining your thought process and approach. Just be prepared to discuss your ideas and approach in person during the interview.

### **Expected Outcome:**

- **Implementation Plan**: A high-level plan for integrating the recommendation system into the artist pages.
- **Evaluation Plan**: A detailed plan for evaluating the effectiveness of the recommendation system, including proposed metrics and methods for collecting user feedback. -->
<div>
  <p>
    Data Analysis:<br />
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
  </p>
  <br />

  <p>
    Note:<br />
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
