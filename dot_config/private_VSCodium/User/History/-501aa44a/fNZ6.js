export class History {
  maxLength = 500;

  #states = [];

  constructor(maxLength) {
    this.maxLength ||= maxLength;
  }

  saveState(newState) {
    if (this.#states.length >= this.maxLength) {
      this.#states.shift(); // Remove the oldest item
    }

    this.#states.push(structuredClone(newState));
  }

  // Get the state at the given index
  // 0 is the latest
  getState(index = 0) {}
}
