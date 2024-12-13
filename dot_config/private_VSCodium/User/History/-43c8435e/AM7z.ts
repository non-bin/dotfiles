export default class HistoryManager {
  #maxLength: number = 500;
  #states: any[] = [];

  constructor(maxLength: number | null) {
    this.#maxLength = maxLength || this.#maxLength;
  }

  push(newState: {}) {
    if (this.#states.length >= this.#maxLength) {
      this.#states.shift(); // Remove the oldest item
    }

    this.#states.push(structuredClone(newState));
  }

  /**
   * Remove a state from the history and return it
   *
   * @return {*} The state
   */
  pop() {
    return this.#states.pop();
  }
}
