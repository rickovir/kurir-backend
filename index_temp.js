const express = require('express');
const app = express();
const db = require('./mysql_model.js');

app.use(express.json());

// route
app.get('/',(req, res) => {
	res.send('Hello World');
});
app.get('/api/courses',(req,res) => {
	res.send(courses);
});

app.get('/api/courses/:id',(req,res) => {
	const course = courses.find(c => c.id === parseInt(req.params.id));
	if(!course)
		return res.status(404).send('the course with given ID was not found');
	res.send(course);
});

app.get('/api/posts/:year/:month',(req,res) => {
	res.send(req.query);
});

app.post('/api/courses', (req,res) => {
	const course = {
		id:courses.length +1,
		name: req.body.name
	};
	courses.push(course);
	res.send(course);
});

app.post('/api/material', (req,res) => {

	const {error} = modeldb.validateCourse(req.body);

	if(error)
	{
		return status(400).send(error.details[0].message)
	}
	const course = {
		id:courses.length +1,
		name: req.body.name
	};
	courses.push(course);
	res.send(course);
});


// restaurant start here

app.get('/api/test/',(req, res)=>{
	db.query(`
		insert into jklrest
		(id, namaLengkap, username, password, email)
		values(0, 
		${req.body.namaLengkap},
		${req.body.username},
		${req.body.password},
		${req.body.email}
		)`,	
		(error, results, fields)=> {
			if(error)
				throw error;
			res.send(results);
		});
});
// app.post('/api/testa/',(req, res)=>{
// 	console.log(req.body.username);
// 	res.send(req.body);
// });


app.post('/api/register/',(req, res)=>{
	let body = req.body;
	db.query(`
		insert into user
		(id, namaLengkap, username, password, email)
		values (0, 
		'${Buffer.from(body.namaLengkap, 'base64').toString()}',
		'${Buffer.from(body.username, 'base64').toString()}',
		'${body.password}',
		'${Buffer.from(body.email, 'base64').toString()}'
		)`,	
		(error, results, fields)=> {
			if(error)
				throw error;
			res.send(results);
		});
});

app.post('/api/auth',(req,res)=>{
	db.query(`select * from user where 
		username='${Buffer.from(req.body.username, 'base64').toString()}' 
		and password='${req.body.password}'`,
		(error, results, fields)=>{
			if(error){
				// throw error;
				res.send({
					"code":400,
					"failed":"error ocurred",
					"error" : error,
					"enter":"N"
				});
			}
			else
			{
				if(results.length >0)
				{
					res.send({
						"code":200,
						"message":"login berhasil",
						"enter":"Y",
						"status": "OK"
					});
				}
				else
				{
					res.send({
						"code":200,
						"message":"login gagal",
						"enter":"N",
						"status": "OK"
					});
				}
			}
		});
});







const port = process.env.PORT || 3000;

app.listen(port, () => console.log(`listening on port ${port}..`));