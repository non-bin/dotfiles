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

const a = new A();
a.b = {};
a.b.c = 1;
