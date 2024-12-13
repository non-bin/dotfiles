<script lang="ts">
  let { artistTrends } = $props();

  function formatHour(hour: number) {
    return hour < 12 ? `${hour} AM` : `${hour} PM`;
  }
</script>

<div class="overflow-x-auto">
  <div class="min-w-max w-[60rem] h-[60rem] overflow-y-auto relative scrollbar-pretty">
    <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
      <thead
        class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400 sticky top-0"
      >
        <tr>
          <th scope="col" class="px-6 py-3">Artist Name</th>
          <th scope="col" class="px-6 py-3">12am</th>
          <th scope="col" class="px-6 py-3">1am</th>
          <th scope="col" class="px-6 py-3">2am</th>
          <th scope="col" class="px-6 py-3">3am</th>
          <th scope="col" class="px-6 py-3">4am</th>
          <th scope="col" class="px-6 py-3">5am</th>
          <th scope="col" class="px-6 py-3">6am</th>
          <th scope="col" class="px-6 py-3">7am</th>
          <th scope="col" class="px-6 py-3">8am</th>
          <th scope="col" class="px-6 py-3">9am</th>
          <th scope="col" class="px-6 py-3">10am</th>
          <th scope="col" class="px-6 py-3">11am</th>
          <th scope="col" class="px-6 py-3">12pm</th>
          <th scope="col" class="px-6 py-3">1pm</th>
          <th scope="col" class="px-6 py-3">2pm</th>
          <th scope="col" class="px-6 py-3">3pm</th>
          <th scope="col" class="px-6 py-3">4pm</th>
          <th scope="col" class="px-6 py-3">5pm</th>
          <th scope="col" class="px-6 py-3">6pm</th>
          <th scope="col" class="px-6 py-3">7pm</th>
          <th scope="col" class="px-6 py-3">8pm</th>
          <th scope="col" class="px-6 py-3">9pm</th>
          <th scope="col" class="px-6 py-3">10pm</th>
          <th scope="col" class="px-6 py-3">11pm</th>
        </tr>
      </thead>
      <tbody>
        {#each artistTrends as { artist_id, artist_name, hour, engagment }}
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
              {formatHour(hour)}
            </td>
            <td class="px-6 py-4">
              {engagment}
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
