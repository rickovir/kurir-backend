const express = require('express');
const app = express();
const db = require('./mysql_model.js');
// get connection
var con = db.connection();
// start connection
con.connect();
// console.log(db.insert("kurir", {IDKurir:"123123",nama:"namamu yah"}));
// console.log(db.update("kurir", {trash:"Y"}, {IDKurir:"123123"}));
// console.log(db.findWhere("paket_barang",{IDPaket:"123123",nama_paket:"enak banger"}));

con.query(db.findAll("paket_barang"),(error, results, fields)=> {
		if(error)
			throw error;
	console.log(results);
});