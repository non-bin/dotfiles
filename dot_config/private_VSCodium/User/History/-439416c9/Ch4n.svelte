<script lang="ts">
  import EngagementTable from '$lib/components/engagementTrendTable.svelte';
  import Chart from '$lib/components/Chart.svelte';
  import type { PageData } from './$types';

  let { data }: { data: PageData } = $props();

  let sumChart = $state(false);
</script>

<div class="flex flex-col items-center justify-center">
  <Chart data={data.data} {sumChart} />
</div>

<input
  type="checkbox"
  name="sumChart"
  id="sumChart"
  onchange={() => (sumChart = !sumChart)}
/>
<label for="sumChart">Sum Engagements</label>

<div class="flex flex-col">
  <EngagementTable artistTrends={data.data} />
</div>
