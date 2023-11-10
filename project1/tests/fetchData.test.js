// fetchData.test.js
const fetchData = require("../src/fetchData");

test("fetchData should return data from the API", async () => {
  const id = 1;
  //Run the function
  const data = await fetchData(id);

  //Test for Keys
  expect(data).toHaveProperty("userId");
  expect(data).toHaveProperty("id");
  expect(data).toHaveProperty("title");
  expect(data).toHaveProperty("body");

  //Ensure that UserId and Ud are numbers
  expect(typeof data.userId).toBe("number");
  expect(typeof data.id).toBe("number");
});

test("fetchData should throw an error if id is not provided", async () => {
  // Ensure that an error is thrown when id is not provided
  await expect(fetchData()).rejects.toThrow(
    "Please provide an id as a command line argument.",
  );
});
