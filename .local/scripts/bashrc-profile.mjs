#!/usr/bin/env node
import assert from 'node:assert/strict';
import { readdir, readFile } from 'node:fs/promises';

async function profile() {
  const files = await readdir('/tmp');
  let max = 0, newestFile = null;
  for (const file of files) {
    if (file.startsWith('bashstart')) {
      const [_, pid] = file.match(/bashstart\.(\d+)/);
      assert(pid !== undefined)
      max = Math.max(max, Number(pid));
      (max === Number(pid)) && (newestFile = file);
    }
  }

  console.log('File: /tmp/' + newestFile);

  assert(newestFile !== null);

  const content = await readFile('/tmp/' + newestFile, 'utf8');
  /** @type [number, string][] */
  const commands = content.split('\n').filter((v) => v.startsWith('+')).map((command) => {
    const [_, sec, nanoSec] = command.match(/(\d+)\.(\d+)/);
    assert(sec !== undefined && nanoSec !== undefined);
    const time = Number(sec + nanoSec);
    return [time, command]
  })

  const commandsWithInterval = commands.map(([time, command], i) => {
    if (i === commands.length - 1)
      return [0, command]
    else
      return [commands[i + 1][0] - time, command]
  })

  commandsWithInterval.sort(([a, _], [b, __]) => b - a)
  console.log(commandsWithInterval.slice(0, 10).map(([time, command]) => `Time: ${time}, Command: ${command}`).join('\n'))
}

profile();
