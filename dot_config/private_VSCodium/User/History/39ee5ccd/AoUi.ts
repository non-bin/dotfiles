import * as utils from './utilities.js';
import Screen from './screen.js';

const HISTORY_LENGTH = 500;
const LONG_TOUCH_DURATION = 500; // ms
const SPEED_MODE_INTERVAL = 50; // ms

const screen = new Screen(HISTORY_LENGTH);

const modalElement = document.getElementById('modal');
const modalCloseElement = document.getElementById('modal-close');
if (!modalElement) throw new Error('Modal element not found');
if (!modalCloseElement) throw new Error('Modal close element not found');

const showModal = () => {
  modalElement.style.display = 'block';
};

const hideModal = () => {
  modalElement.style.display = 'none';
};

let longTouchTimer: number | null;
let speedModeTimer: number | null;
let touchPosition: [x: number, y: number];

const longTouch = () => {
  const positionAsProportion = utils.getPositionAsProportion(touchPosition);

  // eslint-disable-next-line no-magic-numbers
  if (positionAsProportion[0] < 0.5) {
    showModal();
  } else {
    speedModeTimer = setInterval(
      () => screen.incrementAll(),
      SPEED_MODE_INTERVAL
    );
  }

  longTouchTimer = null;
};

const shortTouch = () => {
  const positionAsProportion = utils.getPositionAsProportion(touchPosition);

  // eslint-disable-next-line no-magic-numbers
  if (positionAsProportion[0] < 0.5) {
    screen.undo();
  } else {
    screen.incrementAll();
  }
};

const handleClick = () => {
  if (Screen.getPreference('mobileFullscreen')) {
    utils.requestFullscreen();
  }
};

const touchStart = (touchEvent: TouchEvent) => {
  // FIXME: When this is enabled, the click event doesn't fire
  // but requestFullscreen is unreliable when called from touchstart #12
  // so we need to use the click event instead
  // https://stackoverflow.com/questions/79132797/requestfullscreen-is-unreliable-when-called-from-touchstart
  // touchEvent.preventDefault(); // Prevent the browser from processing emulated mouse events

  const touch = touchEvent.targetTouches.item(0);
  if (!touch) return;

  touchPosition = [touch.clientX, touch.clientY];

  longTouchTimer = setTimeout(longTouch, LONG_TOUCH_DURATION, touchEvent);
};

const touchEnd = (touchEvent: TouchEvent) => {
  if (longTouchTimer) {
    // Lifted finger before long touch
    clearTimeout(longTouchTimer);
    longTouchTimer = null;

    shortTouch();
  } /* else {
    // Lifted finger after long touch
  } */

  if (speedModeTimer) {
    clearInterval(speedModeTimer);
    speedModeTimer = null;
  }
};

const touchMove = () => {
  // Not used, but don't cancel the event
};

const touchCancel = () => {
  if (longTouchTimer) {
    clearTimeout(longTouchTimer);
    longTouchTimer = null;
  }
  if (speedModeTimer) {
    clearInterval(speedModeTimer);
    speedModeTimer = null;
  }
};

if (utils.mobileOrTabletCheck()) {
  const touchCatcherElement = document.getElementById('touchCatcher');
  touchCatcherElement.style.display = 'block';
  window.addEventListener('click', handleClick, false);
  touchCatcherElement.addEventListener('touchstart', touchStart, false);
  touchCatcherElement.addEventListener('touchmove', touchMove, false);
  touchCatcherElement.addEventListener('touchcancel', touchCancel, false);
  touchCatcherElement.addEventListener('touchend', touchEnd, false);
}

modalCloseElement.addEventListener('click', () => {
  hideModal();
});
window.addEventListener('click', (event) => {
  if (event.target === modalElement) {
    hideModal();
  }
});

document.getElementById('backToEditorButton').addEventListener('click', () => {
  const newURL = new URL('./editor.html', window.location);
  newURL.searchParams.set('configID', screen.getCurrentConfigID());
  window.location = newURL;
});
document.getElementById('resetButton').addEventListener('click', () => {
  screen.reset(HISTORY_LENGTH);
  hideModal();
});

document
  .getElementById('fullscreenToggle')
  .addEventListener('click', (event) => {
    event.target.classlist.toggle('checked');

    const checked = event.target.classList.contains('checked');
    Screen.setPreference('mobileFullscreen', checked);
  });
