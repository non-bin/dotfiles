/* eslint-disable class-methods-use-this */

import exampleConfigs from './exampleConfigs.js';

/**
 * @typedef {import('./screen').ScreenConfig} ScreenConfig
 */

export default class ConfigManager {
  /** @type {String} */ #currentConfigID;
  /** @type {ScreenConfig[]} */ #configs;
  /** @type {ScreenConfig|null} */ config;

  /**
   * Initialise the config storage if not done already, then load either the
   * requested config, the first available one, or null if none are available
   * or the requested on doesn't exist
   *
   * @param {String?} configID
   */
  constructor(configID) {
    if (!Object.hasOwn(localStorage, 'configs')) {
      this.initialise();
    }

    if (this.numConfigs > 0) {
      this.switchConfig(configID || this.getAvailableConfigsList()[0]);
    }

    this.#currentConfigID = configID;
  }

  /**
   * Reset configs to defaults
   */
  initialise() {
    localStorage.configs = JSON.stringify(exampleConfigs);
  }

  /**
   * @returns {Number} The number of saved configs
   */
  get numConfigs() {
    return this.#configs.length;
  }

  /**
   * @returns {String[]} List of the IDs of all saved configs
   */
  getAvailableConfigsList() {
    return Object.keys(localStorage.configs);
  }

  /**
   * Returns false if the switch failed
   * @param {String} configID
   * @returns {ScreenConfig|false}
   */
  switchConfig(configID) {
    if (
      typeof configID === 'string' &&
      Object.hasOwn(this.getAvailableConfigsList(), configID)
    ) {
      this.config = localStorage.configs[configID];
      this.#currentConfigID = configID;
      return true;
    }
    return false;
  }

  get currentConfigID() {
    return this.#currentConfigID;
  }
}
