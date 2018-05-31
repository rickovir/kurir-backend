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
    		var id = makeResi("PKT");
	    	db.query(`insert into 
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
	    		values(
	    		'',
	    		'${data.IDCabang}',
	    		'${data.nama_paket}',
	    		'${data.no_resi}',
	    		'${data.nama_pengirim}',
	    		'${data.alamat_pengirim}',
	    		'${data.telepon_pengirim}',
	    		'${data.nama_penerima}',
	    		'${data.alamat_penerima}',
	    		'${data.telepon_penerima}',
	    		'${data.berat}',
	    		'${data.kategori_paket}',
	    		'${data.jenis_paket}',
	    		'${data.tarif}',
	    		'${data.created_on}'
	    		)`, 
	    		(error, results, fields)=> {
					if(error)
						client.emit('paket_barang_stream', error);
					io.sockets.emit('paket_barang_stream',{IDPaket:id, data});
				});
	    }
	    else if(data.type=="update")
	    {
	    	db.query(`update 
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
	    		`, 
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

function makeResi(key)
{
	return key + getTime().toString();
}

function getRandomInt(min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
}