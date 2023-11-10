// fetchData.test.js
const fetchData = require("../src/fetchData");

// Mock data for the successful API response
const mockData = {
  userId: 1,
  id: 1,
  title: "mock title",
  body: "mock body",
};
// Mocking the fetchData function to return the mock data
jest.mock("../src/fetchData", () => jest.fn());

test("fetchData should return data from the API", async () => {
  fetchData.mockResolvedValueOnce(mockData);

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
  fetchData.mockRejectedValueOnce(
    new Error("Please provide an id as a command line argument."),
  );

  // Ensure that an error is thrown when id is not provided
  await expect(fetchData()).rejects.toThrow(
    "Please provide an id as a command line argument.",
  );
});
