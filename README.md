# A sample application with known vulnerabilities - JavaScript, Express

A sample application with known issues for testing various linters, scanners,
and scan automation.

This project uses:

| Component   | In Use                                                                                              | 
|-------------|-----------------------------------------------------------------------------------------------------|
| Platform    | [NodeJS](https://nodejs.org/)                                                                       |
| Language(s) | JavaScript ([ECMAScript](https://www.ecma-international.org/publications-and-standards/standards/)) |
| Build       | [npm](https://www.npmjs.com/)                                                                       |
| Framework   | [Express](https://expressjs.com/)                                                                   |

## Security issues

| Vulnerability Type                     | Description                                                                                                                                                                      | Location                                                                      | PoC Command                                                                                                                                                                                                         |
|----------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Cross Site Scripting (XSS)             | The `/hello` endpoint generates page output in code. It expects a name as a parameter to say `"Hello, $name"` and concatenates the user input to the output without escaping it. | ``res.send(`Hello, ${req.query.name}`)``                                      | <http://localhost:8080/hello?name=%3Cscript%3Ealert(1)%3C/script%3E>                                                                                                                                                | 
| Cross Site Scripting (XSS)             | The `/view` endpoint uses a template engine to say `"Hello, $name"` and misuses template syntax, leaving the user input unescaped.                                               | `p!= 'Hello, ' + name`                                                        | <http://localhost:8080/view?name=%3Cscript%3Ealert(1)%3C/script%3E>                                                                                                                                                 |
| Cross Site Scripting (XSS)             | The `/user` endpoint reflects a value from the database directly to the page. Today, it's an ID, but in non statically typed languages this is still always a scenario.          | `res.send(user.rows[0]);`                                                     | This one currently doesn't have a PoC exploit, since it reflects a number from the database to the page. But this is a legit injection scenario that has to be handled. We use it SAST issue prioritization testing |
| Hardcoded credentials                  | There are secrets in the code committed to the repository                                                                                                                        | `POSTGRES_PASSWORD=mysecretpassword`<br/><br/>`password: "mysecretpassword",` | N/A                                                                                                                                                                                                                 |
| SQL Injection (SQLi)                   | The SQL query is constructed using string concatenation instead of using a parameterized query                                                                                   | ``client.query(`select * from users where id = ${req.params.id}`)``           | <http://localhost:8080/user/1;drop%20table%20users></br></br>`sqlmap -u localhost:8080/user/1 --all`                                                                                                                |
| Use of a vulnerable (outdated) library | This project includes`lodash` library version with known vulnerabilities                                                                                                         | `"lodash": "4.17.20"`                                                         | [CVE-2021-23337](https://www.cvedetails.com/cve/CVE-2021-23337/), [CVE-2020-28500](https://www.cvedetails.com/cve/CVE-2020-28500/)                                                                                  |

### Other issues

* There is at least one unused variable
* The project has no tests
* The project dependencies are not locked
* A few `var` instead
  of `const` ([ESlint rule: `no-var`](https://eslint.org/docs/rules/no-var))
* Library `lodash` is declared but never used
* Style is inconsistent. E.g. a [Standard Style](https://standardjs.com/) linter
  would complain.
* Plus container issues if you run `docker build .`

## Running this code

**NOTE: This project contains security vulnerabilities and should be only run in
testing purposes.**

Requirements:
* [NodeJS and npm](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm)
* [Docker](https://www.docker.com/)

To run the code locally:

```shell
# Clone the project
git clone https://github.com/the-scan-project/tsp-vulnerable-app-nodejs-express.git
cd tsp-vulnerable-app-nodejs-express

# Install dependencies
npm i

# Start the database container
docker run --name some-postgres -e POSTGRES_PASSWORD=mysecretpassword -p 5432:5432 -d postgres

# Start the application
npm run start
```
