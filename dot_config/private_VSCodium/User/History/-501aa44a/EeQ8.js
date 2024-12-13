class History {
  length = 500;

  #states = [];

  constructor(length) {
    this.length ||= length;
  }

  saveState(newState) {
    if (this.#states.length >= this.length) {
      this.#states.shift(); // Remove the oldest item
    }

    this.#states.push(structuredClone(newState));
  }
}
