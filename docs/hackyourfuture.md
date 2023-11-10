
---

# Welcome to Spirii

## The dogs
    To the left we have Apollo and to the right is Ra.
    They are 945 days old Alaskan Huskies.

## Here are some practical information

### Wifi

#### Spirii guest

        Network: spirii-guest
        Password: spiriivisitor

#### Backup wifi 
        
        Network: The Library Guests
        Password: thelibrarycph

# Who am I

## Kelvin Riker
    - Tech-Lead of the Connect portal
    - Been with Spirii for 2 years
    - 2 Decades worth of experience in the IT industry, most of it software development
    - 4 Dogs and 1 Cat

---

# Why is automatic testing a good idea.

## Early detection of bugs
    With a good test design, we can have faster feedback loop. 
    In practice this means that you can test while developing a new feature. 
    
## Regression testing
    With larger codebases, complexity is higher. 
    Having tests for all areas means that you can ensure that refactoring or new additions, do not break existing code. 
    
## Consistancy
    With automated tests, everything is run the same way each time. 

## CI/CD Pipeline safety
    Running autmated tests on Commits or Pull Requests ensures that deployments can be stopped if a bug triggers a failed test.

## Executable documentation
    A comprehensive test will show what a feature is suppose to do.

## Security
    Test can be used to test access controls, such as permissions.

---

# Lets setup a nodejs project.

```bash
mkdir project1
cd project1

npm init -y
npm install --save-dev jest axios

mkdir src tests
```

Your project should now look like.

```bash
/project1
├── src 
├── tests
└── package.json
```
---
# What is jest
Jest is a testing framework for Javascript
For most Projects you can get started without any configuration

Jest has a built-In assertion library, which enables you to test without external libraries. 
However you can add assertion libraries if your project is out of scope for the built-in.

--- 
# Configure the test

```json 
{
    "name": "project1",
    "version": "1.0.0",
    "description": "",
    "main": "index.js",
    "scripts": {
        "test": "jest"
    },
    "jest": {
        "testEnvironment": "node"
    },
    "keywords": [],
    "author": "",
    "license": "ISC",
    "dependencies": {
        "axios": "^1.6.1",
        "jest": "^29.7.0"
    }
}
```

---
## Project 1

### The code 

```Javascript
// src/fetchData.js
const axios = require("axios");

async function fetchData() {
  const response = await axios.get(
    "https://jsonplaceholder.typicode.com/posts/1",
  );
  return response.data;
}

module.exports = fetchData;

```

---
## Project 1

### What are the test data 

    https://jsonplaceholder.typicode.com/posts/1

``` json
    {
        "userId": 1,
        "id": 1,
        "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
        "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
    }
```

We are getting json object on which we can test if a key is present.

---
## The code
Lets write a simple function

```javascript
// src/fetchData.js
const axios = require("axios");

async function fetchData() {

  const response = await axios.get("http://jsonplaceholder.typicode.com/posts/1");
  return response.data;
}

module.exports = fetchData;
```

Add an index file to run the function

```javascript
const fetchData = require("./fetchData");

const runScript = async () => {
  try {
    const data = await fetchData();
    console.log("Data from the API:", data);
  } catch (error) {
    console.error("Error:", error.message);
  }
};

runScript();


```

---

## Our first test

``` javascript
// tests/fetchData.test.js
const fetchData = require("../src/fetchData");

test("fetchData should return data from the API", async () => {
  const data = await fetchData();
  expect(data).toHaveProperty("userId");
  expect(data).toHaveProperty("id");
  expect(data).toHaveProperty("title");
  expect(data).toHaveProperty("body");
});
```


---

## Lets update our fetchData function
Since it does not make much sense to always get the same obect from our data source. 
We would like to send a command that fetches other id´s. 

```javascript
// src/fetchData.js
const axios = require("axios");

async function fetchData() {
  const id = process.argv[2];
  const json_source = `http://jsonplaceholder.typicode.com/posts/${id}`;

  const response = await axios.get(json_source);
  return response.data;
}

module.exports = fetchData;

```

---

# Update the test

## Handle inputs

```javascript
  const id = 1;
  //Run the function
  const data = await fetchData(id);
```

## Check for data integrety
```javascript

   //Ensure that UserId and id are numbers
  expect(typeof data.userId).toBe("number");
  expect(typeof data.id).toBe("number");
```

---
## Check for error handling. The second test.

```javascript
test("fetchData should throw an error if id is not provided", async () => {
  // Ensure that an error is thrown when id is not provided
  await expect(fetchData()).rejects.toThrow(
    "Please provide an id as a command line argument.",
  );
```

Add the Error handling to the function

```javascript
if (!id) {
    throw new Error("Please provide an id as a command line argument.");
  }


```
---
## Practical information

### Github profile
    https://github.com/Kelvin-Riker

### Todays repository
    https://github.com/Kelvin-Riker/hyf-test
