<script lang="ts">
  let { artistVisits } = $props();

  /**
   * @param duration Elapsed time in milliseconds
   */
  function formatDuration(duration: number): string {
    const durationInSeconds = duration / 1000;

    let output = '';

    // TODO: Consider always formatting with hours, since every duration is in the thousands of hours

    const hours = durationInSeconds / 60 / 60;
    const minutes = (durationInSeconds % (60*60)) / 60;
    const seconds = durationInSeconds % 60;
    const roundedHours = Math.floor(hours);
    const roundedMinutes = Math.floor(minutes);
    const roundedSeconds = Math.floor(seconds);

    // Option 1
    // return `${roundedHours}`;

    // Option 2
    // return `${roundedHours}:${roundedHinutes < 10 ? "0" : ""}${roundedHinutes}:${roundedHeconds < 10 ? "0" : ""}${roundedHeconds}`;

    // Option 3
    // if (hours > 0) {
    //   output += `${roundedHours}:`;
    // }
    // if (minutes > 0) {
    //   output += `${roundedHinutes}:`;
    // }
    // output += `${roundedHeconds < 10 ? "0" : ""}${roundedHeconds}`;

    return output;
  }

</script>

<div class="overflow-x-auto">
  <div class="min-w-max w-[60rem] h-[60rem] overflow-y-auto relative scrollbar-pretty">
    <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
      <thead
        class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400 sticky top-0"
      >
        <tr>
          <th scope="col" class="px-6 py-3">Artist Id</th>
          <th scope="col" class="px-6 py-3">Artist Name</th>
          <th scope="col" class="px-6 py-3">Total Time Spent (minutes)</th>
          <th scope="col" class="px-6 py-3">Total Unique Visitors</th>
        </tr>
      </thead>
      <tbody>
        {#each artistVisits as { artist_id, artist_name, total_visit_duration, unique_session_count }}
          <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
            <td
              class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white"
            >
              {artist_id}
            </td>
            <td
              class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white"
            >
              {artist_name}
            </td>
            <td class="px-6 py-4">
              {formatDuration(total_visit_duration)}
            </td>
            <td class="px-6 py-4">
              {unique_session_count}
            </td>
          </tr>
        {/each}
      </tbody>
    </table>
  </div>
</div>

<style>
/* Custom scrollbar styles */
.scrollbar-pretty::-webkit-scrollbar {
  width: 10px;
}

.scrollbar-pretty::-webkit-scrollbar-track {
  background: rgba(0, 0, 0, 0.1);
  border-radius: 10px;
}

.scrollbar-pretty::-webkit-scrollbar-thumb {
  background: rgba(149, 158, 160, 0.5);
  border-radius: 5px;
  border: 1px solid rgba(0, 0, 0, 0.1);
}

.scrollbar-pretty::-webkit-scrollbar-thumb:hover {
  background: rgba(100, 100, 100, 0.7);
}

</style>
