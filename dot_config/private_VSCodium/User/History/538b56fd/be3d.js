/* eslint-disable id-length */
const a = {
  message1: 'hello',
  message2: 'everyone'
};

const handler = {
  get(target, prop, receiver) {
    console.log(target, prop, receiver);

    return 'world';
  },

  set(target, prop, value) {
    console.log(target, prop, value);
    target[prop] = value;
  }
};

const proxy = new Proxy(a, handler);

// console.log(proxy.message1);
// console.log(proxy.b);

proxy.b = 1;
