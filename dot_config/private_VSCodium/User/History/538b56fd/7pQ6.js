/* eslint-disable id-length */
class A {
  #b;

  get b() {
    return this.#b;
  }

  set b(newB) {
    this.#b = newB;
    console.log(newB);
  }
}

a = new A();
