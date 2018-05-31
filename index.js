const express = require('express');
const app = express();
const db = require('./mysql_model.js');
const socket = require('socket.io')

app.use(express.json());

app.get('/api/getAllKurir/',(req, res)=>{
	db.query('select * from kurir', (error, results, fields)=>{
		if(error)
			throw error;
		res.send(results);
	});
});


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
        db.query('select * from paket_barang', (error, results, fields)=>{
			if(error)
				throw error;
        	client.emit('show_paket_messages', results);
		});
    });

    client.on('paket_barang_stream', function(data){
    	console.log(data);
    	if(data.type=="add")
    	{
    		var resi = makeResi();
    		var sql = `insert into 
	    		paket_barang(
	    		IDPaket,
	    		IDCabang,
	    		nama_paket, 
	    		no_resi, 
	    		nama_pengirim,
	    		alamat_pengirim,
	    		telepon_pengirim,
	    		nama_penerima,
	    		alamat_penerima,
	    		telepon_penerima,
	    		berat,
	    		kategori_paket,
	    		jenis_paket,
	    		tarif,
	    		created_on)
	    		values ?`;
	    	var values = [
	    		data.IDCabang,
	    		data.nama_paket,
	    		resi,
	    		data.nama_pengirim,
	    		data.alamat_pengirim,
	    		data.telepon_pengirim,
	    		data.nama_penerima,
	    		data.alamat_penerima,
	    		data.telepon_penerima,
	    		data.berat,
	    		data.kategori_paket,
	    		data.jenis_paket,
	    		data.tarif,
	    		getTime().toString()
	    	];

	    	db.query(sql,[values], 
	    		(error, results, fields)=> {
					if(error)
					{
						client.emit('paket_barang_stream', error);
					}

					var send = {
						type:"add",
						data: {
							IDPaket:results.insertId,
				    		IDCabang:values[0],
				    		nama_paket:values[1], 
				    		no_resi:values[2], 
				    		nama_pengirim:values[3],
				    		alamat_pengirim:values[4],
				    		telepon_pengirim:values[5],
				    		nama_penerima:values[6],
				    		alamat_penerima:values[7],
				    		telepon_penerima:values[8],
				    		berat:values[9],
				    		kategori_paket:values[10],
				    		jenis_paket:values[11],
				    		tarif:values[12],
				    		created_on:values[13]
						}
					}

					io.sockets.emit('paket_barang_stream',send);
				});
	    }
	    else if(data.type=="update")
	    {
	    	var sql = `update 
	    		paket_barang
	    		set
	    		IDCabang = '${data.IDCabang}',
	    		nama_paket = '${data.nama_paket}',
	    		no_resi = '${data.no_resi}',
	    		nama_pengirim = '${data.nama_pengirim}',
	    		alamat_pengirim = '${data.alamat_pengirim}',
	    		telepon_pengirim = '${data.telepon_pengirim}',
	    		nama_penerima = '${data.nama_penerima}',
	    		alamat_penerima = '${data.alamat_penerima}',
	    		telepon_penerima = '${data.telepon_penerima}',
	    		berat = '${data.berat}',
	    		kategori_paket = '${data.kategori_paket}',
	    		jenis_paket = '${data.jenis_paket}',
	    		tarif = '${data.tarif}',
	    		created_on = '${data.created_on}'
	    		where
	    		IDPaket = '${data.IDPaket}' 
	    		`;
	    	db.query( sql, 
	    		(error, results, fields)=> {
					if(error)
						client.emit('paket_barang_stream', error);
					io.sockets.emit('paket_barang_stream',{IDPaket:data.IDPaket,data});
				});
	    }
	    else if(data.type == "delete")
	    {
	    	db.query(`delete from paket_barang 
	    		where
	    		IDPaket = '${data.IDPaket}' 
	    		`, 
	    		(error, results, fields)=> {
					if(error)
						client.emit('paket_barang_stream', error);
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
