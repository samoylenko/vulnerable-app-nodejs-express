// DEFENSE-IN-DEPTH FIX for SQL Injection
// Layer 1 (Entry): Validate input type and format
const userId = parseInt(req.params.id, 10);
if (isNaN(userId) || userId < 0) {
    return res.status(400).json({ error: 'Invalid user ID' });
}

// Layer 2 (Business): Use parameterized query
const result = await client.query(
    'SELECT * FROM users WHERE id = $1',
    [userId]
);

// Layer 3 (Output): Return only necessary fields
res.json({ id: result.rows[0]?.id, name: result.rows[0]?.name });atabase: "postgres",
})
client.connect()

var main = async () => {
  await client.query(`
    create table if not exists users
    (
        id       serial constraint users_pk primary key,
        email    text not null,
        name     text not null,
        password text
    );
    create unique index if not exists users_email_uindex on users (email);
    create unique index if not exists users_id_uindex on users (id);
  `)

  var unused = "unused variable";

  var app = express();

  app.get('/hello', function (req, res) {
    res.send(`Hello, ${req.query.name}`)
  })

  app.set("view engine", "pug");

  app.get('/view', function (req, res) {
    res.render("hello", { name: req.query.name })
  })

  app.get('/user/:id', async function (req, res) {
    try {
      var user = await client.query(`select *
                                     from users
                                     where id = ${req.params.id}`)
      res.send(user.rows[0]);
    } catch (e) {
      console.error(e.message)
      res.send({ "error": e.message });
    }
  })

  app.listen(port);

  return `Listening on port ${port}`
}

main()
  .then(console.log)
  .catch(console.error)
