import fs from "node:fs/promises";
import readline from "node:readline";
import os from "node:os";
import path from "node:path";

/** @param key { string } */
export async function getEnv(key) {
	const secretHandle = await fs.open(path.join(os.homedir(), ".env"));

	const secretStream = secretHandle.createReadStream();
	const rl = readline.createInterface({ input: secretStream });

	for await (const line of rl) {
		const pair = line.split("=");
		if (pair[0] === key) return pair[1];
	}

	return undefined;
}
