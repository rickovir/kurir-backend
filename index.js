
/* db connection */
const db = require('./modeldb.js');
var con = db.connection();
// start connection
con.connect();

/* server */
const express = require('express');
const app = express();
const socket = require('socket.io')

app.use(express.json());

/*app.get('/api/getAllKurir/',(req, res)=>{
	db.query('select * from kurir', (error, results, fields)=>{
		if(error)
			throw error;
		res.send(results);
	});
});*/


app.use(express.static('public'));

const port = process.env.PORT || 3000;

var server = app.listen(port, () => console.log(`listening on port ${port}..`));

var io = socket(server);

io.on('connection', function(client){
	console.log('made socket connection ', client.id)

	client.on('chat', function(data){
		io.sockets.emit('chat',data)
	});

	// to give packet_barang request
	client.on('show_paket', function(data) {
        console.log(data);
        con.query(db.findAll("paket_barang"), (error, results, fields)=>{
			if(error)
				throw error;
        	client.emit('show_paket_messages', results);
		});
    });

    client.on('paket_barang_stream', function(data){
    	console.log(data);
    	if(data.type=="add")
    	{	
    		// buat resi
    		var resi = makeResi();
    		//set data yang akan di insert
	    	var data = {
	    		IDCabang: data.IDCabang,
	    		nama_paket: data.nama_paket,
	    		no_resi: resi,
	    		nama_pengirim: data.nama_pengirim,
	    		alamat_pengirim: data.alamat_pengirim,
	    		telepon_pengirim: data.telepon_pengirim,
	    		nama_penerima: data.nama_penerima,
	    		alamat_penerima: data.alamat_penerima,
	    		telepon_penerima: data.telepon_penerima,
	    		berat: data.berat,
	    		kategori_paket: data.kategori_paket,
	    		jenis_paket: data.jenis_paket,
	    		tarif: data.tarif,
	    		created_on: getTime().toString()
	    	};

	    	// jalankan query
	    	con.query(db.insert("paket_barang", data) , 
	    		(error, results, fields)=> {
					if(error)
					{
						client.emit('paket_barang_stream', error);
					}
					// set data yg mau dikirim
					var send = {
						type:"add",
						IDPaket : results.insertId,
						data
					}
					// emittt
					io.sockets.emit('paket_barang_stream',send);
				});
	    }
	    else if(data.type=="update")
	    {
	    	var id = data.IDPaket;
    		//set data yang akan di update
	    	var data = {
	    		IDCabang: data.IDCabang,
	    		nama_paket: data.nama_paket,
	    		no_resi: data.no_resi,
	    		nama_pengirim: data.nama_pengirim,
	    		alamat_pengirim: data.alamat_pengirim,
	    		telepon_pengirim: data.telepon_pengirim,
	    		nama_penerima: data.nama_penerima,
	    		alamat_penerima: data.alamat_penerima,
	    		telepon_penerima: data.telepon_penerima,
	    		berat: data.berat,
	    		kategori_paket: data.kategori_paket,
	    		jenis_paket: data.jenis_paket,
	    		tarif: data.tarif,
	    		created_on: data.created_on
	    	};
	    	// jalankan query
	    	con.query(db.update("paket_barang",data,{IDPaket:id}), 
	    		(error, results, fields)=> {
					if(error){
						client.emit('paket_barang_stream', error);
					}
					// set data yg mau dikirim
					var send = {
						type:"update",
						IDPaket : id,
						data
					}
					// emittt
					io.sockets.emit('paket_barang_stream',send);
				});
	    }
	    else if(data.type == "delete")
	    {
	    	// jalankan query delete data
	    	con.query(db.update("paket_barang",{trash:"Y"},{IDPaket:data.IDPaket}), 
	    		(error, results, fields)=> {
					if(error){
						client.emit('paket_barang_stream', error);
					}
					// set data yg mau dikirim
					var send = {
						type:"delete",
						IDPaket : data.IDPaket,
						data
					};
					//emitt
					io.sockets.emit('paket_barang_stream',{IDPaket:data.IDPaket,data});
				});
	    }
    })
});



function getTime()
{
	return new Date().getTime();
}

function getRandomInt(min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
}

function makeResi()
{
	return getTime().toString() + getRandomInt(100,999).toString();
}
