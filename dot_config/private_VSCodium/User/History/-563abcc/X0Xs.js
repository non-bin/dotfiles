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

    this.#configs = JSON.parse(localStorage.configs);

    if (this.getAvailableConfigsList().length > 0) {
      this.switchConfig(configID || this.getAvailableConfigsList()[0]);
    }

    this.#currentConfigID = configID;
  }

  /**
   * Reset configs to defaults
   */
  initialise() {
    this.#configs = structuredClone(exampleConfigs);
    this.saveChanges();
  }

  /**
   * @returns {String[]} List of the IDs of all saved configs
   */
  getAvailableConfigsList() {
    return Object.keys(this.#configs);
  }

  /**
   * Returns false if the switch failed
   * @param {String} configID
   * @returns {ScreenConfig|false}
   */
  switchConfig(configID) {
    console.log(
      configID,
      this.getAvailableConfigsList(),
      configID in this.getAvailableConfigsList()
    );

    if (
      typeof configID === 'string' &&
      configID in this.getAvailableConfigsList()
    ) {
      this.config = this.#configs[configID];
      this.#currentConfigID = configID;
      console.log(this.config);

      return true;
    }
    return false;
  }

  saveChanges() {
    localStorage.configs = JSON.stringify(this.#configs);
  }

  get currentConfigID() {
    return this.#currentConfigID;
  }
}
