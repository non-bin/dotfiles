<script>
  import SvelteMarkdown from 'svelte-markdown';
  const source = `
  # This is a header

This is a paragraph.

* This is a list
* With two items
  1. And a sublist
  2. That is ordered
    * With another
    * Sublist inside

| And this is | A table |
|-------------|---------|
| With two    | columns |`;
</script>

<SvelteMarkdown {source} />

<style>
  h1,
  h2,
  h3,
  h4,
  h5,
  h6 {
    font-size: inherit !important;
    font-weight: inherit !important;
  }
</style>
