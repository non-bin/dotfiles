<script lang="ts">
  import EngagementTable from '$lib/components/engagementTrendTable.svelte';
  import Chart from '$lib/components/Chart.svelte';
  import type { PageData } from './$types';

  let { data }: { data: PageData } = $props();

  // make a globally accessible artistID
  export let artistID = 0;
</script>

<div class="flex flex-col items-center justify-center">
  <Chart data={data.data} {artistID} />
</div>
<div class="flex flex-col">
  <EngagementTable artistTrends={data.data} />
</div>
