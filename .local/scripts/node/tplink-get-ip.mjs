#!/usr/bin/env node
import { getEnv } from "./read-secret.mjs";

const authRes = await fetch("http://192.168.0.1", {
  body: JSON.stringify({
    method: "do",
    login: { password: await getEnv("TPLINK_AUTH") },
  }),
  method: "POST",
  headers: {
    Origin: "http://192.168.0.1",
    Referer: "http://192.168.0.1/",
  },
});

/** @type {{ stok: string }} */
const { stok } = await authRes.json();

const dsRes = await fetch(`http://192.168.0.1/stok=${decodeURI(stok)}/ds`, {
  body: JSON.stringify({
    system: {
      name: ["sys"],
    },
    hosts_info: {
      table: "host_info",
    },
    network: {
      name: "iface_mac",
    },
    function: {
      name: "new_module_spec",
    },
    method: "get",
  }),
  method: "POST",
  headers: {
    Origin: "http://192.168.0.1",
    Referer: "http://192.168.0.1/",
  },
});

const table = await dsRes.json();
console.log(
  table.hosts_info.host_info
    .map((host) => Object.values(host))
    .reduce((hosts, cur) => cur.concat(...hosts), [])
    .map((host) => [host.ip, decodeURI(host.hostname)]),
);
