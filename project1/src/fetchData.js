// fetchData.js
const axios = require("axios");

async function fetchData(id = process.argv[2]) {
  const json_source = `http://jsonplaceholder.typicode.com/posts/${id}`;

  if (!id) {
    throw new Error("Please provide an id as a command line argument.");
  }

  console.log(json_source);
  const response = await axios.get(json_source);
  return response.data;
}

module.exports = fetchData;
