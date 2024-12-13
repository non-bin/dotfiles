<script lang="ts">
  let { data }: { data: { artistName: string; scoresByHour: number[] }[] } =
    $props();

  /**
   * Convert a numeric hour to human readable format e.g. 1am, 2pm
   */
  function hourToLabel(hour: number): string {
    return hour < 12 ? `${hour}am` : hour === 12 ? '12pm' : `${hour - 12}pm`;
  }

  import { onMount } from 'svelte';
  import * as am5 from '@amcharts/amcharts5?client';
  import * as am5xy from '@amcharts/amcharts5/xy?client';
  import * as am5radar from '@amcharts/amcharts5/radar?client';
  import am5themes_Animated from '@amcharts/amcharts5/themes/Animated?client';
  import am5themes_Dark from '@amcharts/amcharts5/themes/Dark?client';

  let chartdiv: HTMLDivElement;
  onMount(() => {
    let root = am5.Root.new(chartdiv);
    root.setThemes([am5themes_Animated.new(root), am5themes_Dark.new(root)]);
    let chart = root.container.children.push(am5radar.RadarChart.new(root, {}));

    let hourAxis = chart.xAxes.push(
      am5xy.CategoryAxis.new(root, {
        categoryField: 'time',
        renderer: am5radar.AxisRendererCircular.new(root, {})
      })
    );
    hourAxis.data.setAll(
      Array.from({ length: 24 }, (_, i) => {
        return { time: hourToLabel(i) };
      })
    );

    let engagementAxis = chart.yAxes.push(
      am5xy.ValueAxis.new(root, {
        renderer: am5radar.AxisRendererRadial.new(root, {})
      })
    );

    // hourAxis.data.setAll(data);
    let series = chart.series.push(
      // am5radar.SmoothedRadarLineSeries.new(root, {
      am5radar.RadarLineSeries.new(root, {
        name: 'Series',
        xAxis: hourAxis,
        yAxis: engagementAxis,
        valueYField: 'value',
        categoryXField: 'time'
      })
    );

    const formattedData = data[1].scoresByHour.map((score, hour) => {
      return {
        time: hourToLabel(hour),
        value: score
      };
    });
    series.data.setAll(formattedData);

    console.log(formattedData);

    return () => {
      root.dispose();
    };
  });
</script>

<div class="chart" bind:this={chartdiv}></div>

<style>
  .chart {
    width: 100%;
    height: 500px;
  }
</style>
