/* eslint-disable id-length */
class a {
  #b;

  get b() {
    return this.#b;
  }

  set b(newB) {
    this.#b = newB;
    console.log(newB);
  }
}
