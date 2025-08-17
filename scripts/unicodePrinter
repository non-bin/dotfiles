#!/usr/bin/env node

const start = parseInt(process.argv[2], 16);
const end = parseInt(process.argv[3], 16);
let currentWidth = 0;

for (let i = start; i < end; i++) {
  const codePoint = i.toString(16);
  currentWidth += codePoint.length + 5;
  if (currentWidth > process.stdout.columns) {
    process.stdout.write('\n');
    currentWidth = codePoint.length + 5;
  }
  process.stdout.write(`${codePoint}: ${JSON.parse(`"\\u${codePoint}"`)}  `);
}

process.stdout.write('\n');
