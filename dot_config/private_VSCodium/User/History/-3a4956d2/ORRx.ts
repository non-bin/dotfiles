import * as utils from './utilities.js';
import Screen, { PostResetCallback, ScreenGrid } from './screen.js';

// eslint-disable-next-line prefer-const
let screen: Screen;

declare global {
  var dirty: boolean;
}

/**
 * @typedef {import('./counter.js').default} Counter
 * @typedef {import('./counter.js').CounterEditHandler} CounterEditHandler
 * @typedef {import('./screen.js').ScreenGrid} ScreenGrid
 * @typedef {import('./screen.js').PostResetCallback} PostResetCallback
 */

const HISTORY_LENGTH = 500;

const sideRulerElement = document.getElementById('side-ruler');
const topRulerElement = document.getElementById('top-ruler');
const configListElement = document.getElementById('config-id-selector');

/**
 * Set the grid templates for the rulers, and update the display
 */
const setRulerGridTemplates = (params: ScreenGrid) => {
  if (!topRulerElement) throw new Error('Top ruler element not found');
  if (!sideRulerElement) throw new Error('Side ruler element not found');

  const { rows, columns } = params;

  let gridTemplate = '';
  for (let columnNum = 0; columnNum < columns.length; columnNum++) {
    gridTemplate += `${columns[columnNum]} `;
  }
  topRulerElement.style.gridTemplate = `auto/${gridTemplate}`;

  gridTemplate = '';
  for (let rowNum = 0; rowNum < rows.length; rowNum++) {
    gridTemplate += `${rows[rowNum]} `;
  }
  sideRulerElement.style.gridTemplate = `${gridTemplate}/auto`;
};

/**
 * Setup the list of config IDs below the editor
 *
 * @param {String[]} availableIDs
 * @param {String} currentID
 */
const setConfigIDList = () => {
  if (!configListElement) throw new Error('Config ID selector not found');
  configListElement.innerHTML = '';

  const availableIDs = screen.getAvailableConfigIDs();
  const currentID = screen.getCurrentConfigID();

  if (!availableIDs.includes(currentID)) {
    throw new Error('Config ID not in list of available');
  }

  for (let IDNo = 0; IDNo < availableIDs.length; IDNo++) {
    const ID = availableIDs[IDNo];

    const optionElement = configListElement.appendChild(
      document.createElement('option')
    );

    optionElement.value = ID || '';
    optionElement.innerText = ID || '';
    if (ID === currentID) optionElement.selected = true;
  }
};

/**
 * Reset rulers from a new config
 */
const resetRulers: PostResetCallback = (config, alternateScreen = screen) => {
  if (!topRulerElement) throw new Error('Top ruler element not found');
  if (!sideRulerElement) throw new Error('Side ruler element not found');

  const { rows, columns } = config.grid || {
    rows: ['auto'],
    columns: ['auto']
  };

  topRulerElement.innerHTML = '';
  sideRulerElement.innerHTML = '';

  setConfigIDList();
  setRulerGridTemplates({ rows, columns });

  for (let columnNum = 0; columnNum < columns.length; columnNum++) {
    const divisionElement = topRulerElement.appendChild(
      document.createElement('div')
    );
    divisionElement.classList.add('ruler-division');
    divisionElement.style.gridArea = `1/${columnNum + 1}/2/${columnNum + 2}`; // eslint-disable-line no-magic-numbers
    const inputElement = divisionElement.appendChild(
      document.createElement('input')
    );
    inputElement.value = columns[columnNum] || '';
    inputElement.addEventListener('input', (event) => {
      const eventTarget = event.target as HTMLInputElement;
      if (!eventTarget.value) return;

      alternateScreen.updateGrid({
        column: columnNum,
        newSize: eventTarget.value
      });
      setRulerGridTemplates({ rows, columns });

      globalThis.dirty = true;
    });
  }

  for (let rowNum = 0; rowNum < rows.length; rowNum++) {
    const divisionElement = sideRulerElement.appendChild(
      document.createElement('div')
    );
    divisionElement.classList.add('ruler-division');
    divisionElement.style.gridArea = `${rowNum + 1}/1/${rowNum + 2}/2`; // eslint-disable-line no-magic-numbers
    const inputElement = divisionElement.appendChild(
      document.createElement('input')
    );
    inputElement.value = rows[rowNum] || '';
    inputElement.addEventListener('input', (event) => {
      alternateScreen.updateGrid({
        row: rowNum,
        newSize: (event.target as HTMLInputElement).value
      });
      setRulerGridTemplates(config.grid);

      globalThis.dirty = true;
    });
  }
};

/** @type {CounterEditHandler} */
const editHandler = (counter, params) => {
  if (params?.event === 'move' || params?.event === 'resize') {
    const newLayout = counter.updateLayout(params.event, params.direction);
    const grid = screen.getGrid();

    if (newLayout.location[0] + newLayout.size[0] >= grid.columns.length) {
      grid.columns.push('auto');
    } else if (newLayout.location[1] + newLayout.size[1] >= grid.rows.length) {
      grid.rows.push('auto');
    }

    screen.setGrid(grid);
    resetRulers({ grid });
  } else {
    return false;
  }

  globalThis.dirty = true;

  return true;
};

screen = new Screen(HISTORY_LENGTH, editHandler, resetRulers);

document.getElementById('increment').addEventListener('click', () => {
  screen.incrementAll();
});
document.getElementById('undo').addEventListener('click', () => {
  screen.undo();
});
document.getElementById('reset').addEventListener('click', () => {
  screen.reset(HISTORY_LENGTH);
});
document.getElementById('save').addEventListener('click', () => {
  screen.saveChanges();
  globalThis.dirty = false;
});
document.getElementById('exit').addEventListener('click', () => {
  const newURL = new URL('./', window.location);
  newURL.searchParams.set('configID', screen.getCurrentConfigID());
  window.location = newURL;
});
document
  .getElementById('config-id-selector')
  .addEventListener('change', (event) => {
    screen.switchConfig(event.target.value);
  });

document.getElementById('toggleFullscreen').addEventListener('click', () => {
  utils.requestToggleFullscreen();
});
document.getElementById('reset-all-configs').addEventListener('click', () => {
  screen.initialiseConfigs();
  screen.reset(HISTORY_LENGTH);
});

window.addEventListener('beforeunload', (event) => {
  if (globalThis.dirty) {
    event.preventDefault(); // Prompt to save
  }
});
