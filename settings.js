const port = 10001;
const host = "192.168.100.8";
const tanks = [1, 2, 3, 4, 5, 6, 7];
const sensors = [1];

const commands = {
  status: { key: "I301", title: "LIQUID STATUS REPORT" },
  inventory: { key: "I201", title: "IN-TANK INVENTORY" },
  capacity: { key: "I604", title: "TANK FULL VOLUME" },
  ullage: { key: "I21A", title: "INVENTORY REPORT" },
};

const cnt = {
  soh: "\x01",
  etx: "\x03",
};

const logging = {
  location_id: 100,
  name: "Thompson Dips",
  email: {
    from: { name: "Thompson Dips", address: "dips@gmx.ca" },
    host: "mail.gmx.com",
    user: "franco@gmx.us",
    pass: "1618 gmx",
    port: 587,
    time: ["06:00:00", "12:00:00", "18:00:00", "23:59:00"],
  },

  storage_period: 5,
  receivers: ["me@me.com", "you@you.com"],
};

const products = {
  unknown: 1,
  diesel: 2,
  diesel_dyed: 3,
  regular: 4,
  premium: 5,
  gas: 6,
  def: 7,
};

exports.port = port;
exports.host = host;

exports.tanks = tanks;
exports.sensors = sensors;

exports.cnt = cnt;
exports.commands = commands;

exports.logging = logging;
exports.products = products;
