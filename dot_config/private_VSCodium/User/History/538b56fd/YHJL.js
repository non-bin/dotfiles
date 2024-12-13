/* eslint-disable id-length */
const a = {
  b: 'a',
  get b() {
    return this.b;
  },
  set b(name) {
    this.log.push(name);
  },
  log: []
};

a.b = 'EN';
a.b = 'FA';

console.log(a.log);
// Expected output: Array ["EN", "FA"]
