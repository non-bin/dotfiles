let counters = {};
/* All counter obj parameters:
{
  internalCounterID: {
    name: 'Counter Display Name',
    position: 'top', // left, right, top, bottom, top-left, top-right, bottom-left, bottom-right
    max: 12, // Number to stop counting at (inclusive), or Infinity, or omit to imply Infinity
    phases: [
      {
        name: 'Phase Display Name',
        max: 30, // Number, Infinity, or omit to inherit the counter's max
      },
      {...}
    ],
    state: { // Used internally
      value: 16, // Current count we're up to (within a state if it has them)
      phase: 2, // Current phase number
      max: 23 // Current max (of the phase if it has one)
    },
    elements: { // Used internally
      main: <DOM Node>, // Counter div
      name: <DOM Node>, // Counter name element
      phase: <DOM Node>, // Phase name
      value: <DOM Node>, // Current value
      max: <DOM Node>, // Current max
    }
  },
}
*/

const defaultConfigs = {
  grid: { template: '60% auto / 40% auto' },
  color: 'black',
  counters: {
    phase: {
      name: 'Phase',
      position: [0, 0],
      size: [2, 1],
      phases: [
        { name: 'Hem', max: 30 },
        { name: 'Ankle', max: 50 },
        { name: 'Heel Decrease', max: 15 },
        { name: 'Heal Increase', max: 15 },
        { name: 'Foot', max: 60 },
        { name: 'Toe Decrease', max: 15 },
        { name: 'Toe Increase', max: 15 },
        { name: 'Waste Yarn' }
      ]
    },
    total: {
      name: 'Total',
      color: 'green',
      position: 'bottom-left'
    },
    colour: {
      name: 'Colour',
      position: 'bottom-right',
      phases: [
        { name: 'Red', color: 'red' },
        { name: 'Green', color: 'green' },
        { name: 'Black', color: 'black', max: 2 }
      ],
      max: 3
    }
  }
};

const updateCounterColor = (counter) => {
  counter.elements.main.style.setProperty(
    '--color',
    counter.phases[counter.state.phase].color ||
      counter.color ||
      'color-mix(in oklab, var(--screen-color), rgba(255, 255, 255) 25%)'
  );
};

const increment = () => {
  for (const counterName in counters) {
    if (Object.hasOwn(counters, counterName)) {
      const counter = counters[counterName];
      const valueElement = counter.elements.value;
      const phaseElement = counter.elements.phase;
      const maxElement = counter.elements.max;

      counter.state.value++;

      if (!counter.state.max || counter.state.value <= counter.state.max) {
        // No max, or haven't reached it yet
        valueElement.textContent = counter.state.value;
        continue;
      }

      counter.state.value = 1;

      if (!counter.phases) {
        valueElement.textContent = counter.state.value;
        continue;
      }

      counter.state.phase++;

      if (counter.state.phase >= counter.phases.length) {
        counter.state.phase = 0;
      }

      updateCounterColor(counter);
      counter.state.max =
        counter.phases[counter.state.phase].max || counter.max || Infinity;
      phaseElement.textContent = counter.phases[counter.state.phase].name;
      maxElement.textContent = `/${counter.state.max}`;

      valueElement.textContent = counter.state.value;
    }
  }
};

const addCounter = (screen, counterID, counter) => {
  counter.state = { value: 0 };
  counter.elements = {};

  const mainElement = document.createElement('div');
  mainElement.className = 'counter';
  if (counter.position) {
    mainElement.classList.add(counter.position);
  }
  counter.elements.main = screen.appendChild(mainElement);

  const nameElement = document.createElement('div');
  nameElement.classList.add('counter_text', 'counter_name');
  nameElement.textContent = counter.name;
  counter.elements.name = mainElement.appendChild(nameElement);

  if (counter.phases) {
    counter.state.phase = 0;

    const phaseElement = document.createElement('div');
    phaseElement.classList.add('counter_text', 'counter_phase');
    phaseElement.textContent = counter.phases[0].name;
    counter.elements.phase = mainElement.appendChild(phaseElement);
  }

  const valueElement = document.createElement('div');
  valueElement.classList.add('counter_text', 'counter_value');
  valueElement.textContent = 0;
  counter.elements.value = mainElement.appendChild(valueElement);

  if (counter.max || counter.phases?.[0]?.max) {
    counter.state.max = counter.phases?.[0]?.max || counter.max || Infinity;
    const maxElement = document.createElement('div');
    maxElement.classList.add('counter_text', 'counter_max');
    maxElement.textContent = `/${counter.state.max}`;
    counter.elements.max = mainElement.appendChild(maxElement);
  }

  updateCounterColor(counter);

  return counter;
};

const setup = () => {
  try {
    counters = {};
    const configElement = document.getElementById('config');
    const config = JSON.parse(configElement.value);

    const screen = document.getElementById('screen');
    screen.innerHTML = '';
    screen.style.gridTemplate = config.grid?.template;
    screen.style.setProperty('--screen-color', config.color || 'white');

    for (const counterID in config.counters) {
      if (Object.hasOwn(config.counters, counterID)) {
        counters[counterID] = addCounter(
          screen,
          counterID,
          config.counters[counterID]
        );
      }
    }
  } catch (error) {
    document.getElementById('error').innerText = error.message;
    console.dir(error.message);
  }
};

document.getElementById('increment').addEventListener('click', increment);
document.addEventListener('keydown', (event) => {
  if (event.key === ' ') {
    event.preventDefault();
    event.stopPropagation();
    increment();
  }
});
document.getElementById('reset').addEventListener('click', () => {
  setup();
});
document.addEventListener('DOMContentLoaded', () => {
  document.getElementById('config').value = JSON.stringify(
    defaultConfigs,
    null,
    2 // eslint-disable-line no-magic-numbers
  );
  setup();
});
