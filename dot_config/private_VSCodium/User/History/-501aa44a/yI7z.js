export default class HistoryManager {
  #maxLength = 500;
  #states = [];

  constructor(maxLength) {
    this.#maxLength ||= maxLength;
  }

  /**
   * Add a state to the history
   *
   * @param {*} newState
   * @memberof HistoryManager
   */
  push(newState) {
    if (this.#states.length >= this.#maxLength) {
      this.#states.shift(); // Remove the oldest item
    }

    this.#states.push(structuredClone(newState));
  }

  pop() {
    return this.#states.pop();
  }
}
