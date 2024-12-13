const folder = Deno.args[0];

async function listFiles(folder: string) {
  const files = Deno.readDir(folder);
  for await (const file of files) {
    console.log(file.name);
  }
}

listFiles(folder).catch(console.error);
