
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
	client.on('show_paket_barang', function(data) {
        console.log(data);
	        con.query(db.findDesc("paket_barang", "IDPaket"), (error, results, fields)=>{
				if(error)
					throw error;
	        	client.emit('show_paket_messages', results);
			});
    });
	client.on('select_paket', function(data) {
        console.log(data);
	        con.query(db.findWhere("paket_barang", data), (error, results, fields)=>{
				if(error)
					throw error;
	        	client.emit('select_paket_messages', results);
			});
    });
    // to give cabang request
	client.on('show_cabang', function(data) {
        console.log(data);
	        con.query(db.findAll("cabang"), (error, results, fields)=>{
				if(error)
					throw error;
	        	client.emit('show_cabang_messages', results);
			});
    });

	// to give packet_barang request
	client.on('show_harga', function(data) {
        console.log(data);
        var sql = `SELECT harga_paket.IDCabangTujuan as IDCabang, harga_paket.harga,cabang.nama_cabang FROM harga_paket,cabang WHERE harga_paket.IDCabangTujuan = cabang.IDCabang`;
        con.query(sql, (error, results, fields)=>{
			if(error)
				throw error;
        	client.emit('show_harga_answer', results);
		});
    });

	// to give packet_barang request
	client.on('show_profile_cabang', function(data) {
        console.log(data);
        con.query(db.findAll("profile_cabang"), (error, results, fields)=>{
			if(error)
				throw error;
        	client.emit('show_profile_cabang_answer', results);
		});
    });

    // give harga barang tiap tujuan
    

	// to give packet_barang request
	client.on('show_list_pengiriman', function(data) {
        console.log(data);
		var sql = `SELECT *, nama_paket, lat,lng FROM paket_barang,list_pengiriman 
					WHERE list_pengiriman.IDPaket = paket_barang.IDPaket AND
					list_pengiriman.IDKurir = ${data.IDKurir}`;
        con.query(sql, (error, results, fields)=>{
			if(error)
				throw error;
        	client.emit('init_list_pengiriman', results);
		});
    });

    // show tarif
	client.on('stream_tarif', function(data) {
        // console.log(data);
		var sql = `SELECT sum(tarif) as total FROM paket_barang WHERE trash = 'N'`;
        con.query(sql, (error, results, fields)=>{
			if(error)
				throw error;
        	client.emit('stream_tarif', results);
		});
    });
    // show jumlah
	client.on('stream_jumlahtr', function(data) {
        // console.log(data);
		var sql = `SELECT count(tarif) as jumlah FROM paket_barang WHERE trash = 'N'`;
        con.query(sql, (error, results, fields)=>{
			if(error)
				throw error;
        	client.emit('stream_jumlahtr', results);
		});
    });

    client.on('list_pengiriman_stream', function(data){
    	// io.sockets.emit('list_pengiriman_stream', data);
    	if(data.type=="ubah_status")
    	{	
    		// membuat log tracking
    		var today = new Date();
    		var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
    		var time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
    		var dataLog = {
    			IDPaket:data.IDPaket,
    			created_on : new Date().getTime(),
    			detail : `Pengiriman dengan resi : ${data.no_resi},
    			oleh Kurir : ${data.IDKurir} ${data.status_pengiriman} <br>
    			keterangan : ${data.keterangan}, <br />
    			pada waktu : ${time}, <br >
    			pada tanggal : ${date}
    			`
    		}

	    	con.query(db.insert("log_tracking", dataLog) , 
	    		(error, results, fields)=> {
					if(error)
					{
						// client.emit('paket_barang_stream', error);
						console.log("error");
					}
					// set data yg mau dikirim
        			console.log("log oke")
				});


    		var id = data.IDPengiriman;
    		// jalankan query
    		var data = {
    			IDPengiriman : id,
    			status_pengiriman:data.status_pengiriman,
    			keterangan : data.keterangan
    		}
	    	con.query(db.update("list_pengiriman",data,{IDPengiriman:id}), 
	    		(error, results, fields)=> {
					if(error){
						client.emit('list_pengiriman_stream', error);
					}
					// set data yg mau dikirim
					var send = {
						type:"ubah_status",
						data
					}
					//emit to user
					client.emit('list_pengiriman_stream', {status:"OK"});
					// emittt
					io.sockets.emit('list_pengiriman_stream',send);
				});
    	}
    });

    client.on('list_pengiriman_paket_barang_stream', function(data){
    	io.sockets.emit('list_pengiriman_paket_barang_stream', data);
    });

	client.on('show_list_pengiriman_paket_barang', function(data) {
        console.log(data);
        var sql = `select * from paket_barang where paket_barang.IDPaket IN (select IDPaket from list_pengiriman where IDKurir = '${data.IDKurir}' )`;
        con.query(sql, (error, results, fields)=>{
			if(error)
				throw error;
        	client.emit('init_list_pengiriman_paket_barang', results);
		});
	});

	client.on('kurir_location',function(data){
		io.sockets.emit('kurir_location', data);
	})


	// bagian penerimaan stream paket barang
    client.on('paket_barang_stream', function(data){
    	console.log(data);
    	if(data.type=="add")
    	{	
    		//set data yang akan di insert
	    	var data = {
	    		IDCabang: data.data.IDCabang,
	    		nama_paket: data.data.nama_paket,
	    		no_resi: data.data.no_resi,
	    		nama_pengirim: data.data.nama_pengirim,
	    		alamat_pengirim: data.data.alamat_pengirim,
	    		telepon_pengirim: data.data.telepon_pengirim,
	    		nama_penerima: data.data.nama_penerima,
	    		alamat_penerima: data.data.alamat_penerima,
	    		telepon_penerima: data.data.telepon_penerima,
	    		berat: data.data.berat,
	    		kategori_paket: data.data.kategori_paket,
	    		jenis_paket: data.data.jenis_paket,
	    		tarif: data.data.tarif,
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

					// send to server log pengiriman
					var sendLog = {
						IDPaket : send.IDPaket,
			    		created_on: getTime().toString(),
			    		detail : `Barang telah diterima untuk dikirim ke ${data.alamat_penerima}`
					};

					con.query(db.insert("log_tracking", sendPenerimaan) ,
						(error, results, fields)=> {
							if(error)
							{
								client.emit('paket_barang_stream', error);
							}
							console.log("berhasil");
						});
					// end log pengiriman

					// penerimaan paket pada cabang
					var sendPenerimaan ={
						IDCabang : data.IDCabang,
						jenis_paket : data.jenis_paket,
						IDPaket : send.IDPaket,
			    		waktu_masuk: getTime().toString(),
			    		waktu_keluar: getTime().toString(),
			    		jenis_paket: send.data.jenis_paket,
			    		created_on: getTime().toString()
					};
					
					con.query(db.insert("penerimaan_paket", sendPenerimaan) ,
						(error, results, fields)=> {
							if(error)
							{
								client.emit('paket_barang_stream', error);
							}
							console.log("berhasil");
						});
					console.log(sendPenerimaan);
				});
	    	// end of penerimaan paket
	    }
	    else if(data.type=="update")
	    {
	    	var id = data.IDPaket;
    		//set data yang akan di update
	    	var data = {
	    		IDCabang: data.data.IDCabang,
	    		nama_paket: data.data.nama_paket,
	    		no_resi: data.data.no_resi,
	    		nama_pengirim: data.data.nama_pengirim,
	    		alamat_pengirim: data.data.alamat_pengirim,
	    		telepon_pengirim: data.data.telepon_pengirim,
	    		nama_penerima: data.data.nama_penerima,
	    		alamat_penerima: data.data.alamat_penerima,
	    		telepon_penerima: data.data.telepon_penerima,
	    		berat: data.data.berat,
	    		kategori_paket: data.data.kategori_paket,
	    		jenis_paket: data.data.jenis_paket,
	    		tarif: data.data.tarif,
	    		created_on: data.data.created_on
	    	};
	    	// jalankan query
	    	con.query(db.update("paket_barang",data,{IDPaket:id}), 
	    		(error, results, fields)=> {
					if(error){
						client.emit('paket_barang_stream', error + 'error oy');
					}
					// set data yg mau dikirim
					var send = {
						type:"update",
						IDPaket : id,
						data
					}
					console.log(data);
					// emittt
					io.sockets.emit('paket_barang_stream',send);

					var sendPenerimaan ={
						IDCabang : data.IDCabang,
						jenis_paket : data.jenis_paket
					};

					con.query(db.update("penerimaan_paket", sendPenerimaan, {IDPaket : send.IDPaket}) ,
						(error, results, fields)=> {
							if(error)
							{
								client.emit('paket_barang_stream', error);
							}
							console.log("berhasil");
						});
					console.log(sendPenerimaan);
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
						IDPaket : data.IDPaket
					};
					//emitt
					io.sockets.emit('paket_barang_stream', send);
				});
	    }
    })
	// bagian stream penerimaan paket barang
    client.on('penerimaan_paket_stream', function(data){
    	console.log(data);
    	if(data.type=="add")
    	{	
    		var data = {
	    		IDCabang: data.IDCabang,
	    		IDPaket: data.IDPaket,
	    		waktu_masuk: getTime().toString(),
	    		waktu_keluar: getTime().toString(),
	    		jenis_paket: data.jenis_paket,
	    		created_on: getTime().toString()
	    	};

	    	// jalankan query
	    	con.query(db.insert("penerimaan_paket", data) , 
	    		(error, results, fields)=> {
					if(error)
					{
						client.emit('penerimaan_paket_stream', error);
					}
					// set data yg mau dikirim
					var send = {
						type:"add",
						IDPenerimaan: results.insertId,
						data
					}
					console.log(send);

					// emittt
					io.sockets.emit('penerimaan_paket_stream',send);
				});
	    }
	    else if(data.type=="update")
	    {
	    	var id = data.IDPenerimaan;
    		//set data yang akan di update
    		var data = {
	    		IDCabang: data.IDCabang,
	    		IDPaket: data.IDPaket,
	    		waktu_masuk: getTime().toString(),
	    		waktu_keluar: getTime().toString(),
	    		jenis_paket: data.jenis_paket
	    	};
	    	// jalankan query
	    	con.query(db.update("penerimaan_paket",data,{IDPenerimaan:id}), 
	    		(error, results, fields)=> {
					if(error){
						client.emit('penerimaan_paket_stream', error);
					}
					// set data yg mau dikirim
					var send = {
						type:"update",
						IDPenerimaan : id,
						data
					}
					// emittt
					io.sockets.emit('penerimaan_paket_stream',send);
				});
	    }
	    else if(data.type == "delete")
	    {
	    	// jalankan query delete data
	    	con.query(db.update("penerimaan_paket",{trash:"Y"},{IDPenerimaan:data.IDPenerimaan}), 
	    		(error, results, fields)=> {
					if(error){
						client.emit('penerimaan_paket_stream', error);
					}
					// set data yg mau dikirim
					var send = {
						type:"delete",
						IDPenerimaan : data.IDPenerimaan,
						data
					};
					//emitt
					io.sockets.emit('penerimaan_paket_stream',{IDPenerimaan:data.IDPenerimaan,data});
				});
	    }
	    else if(data.type == "send")
	    {
	    	// jalankan query delete data
	    	con.query(db.update("penerimaan_paket",{isSend:'Y'},{IDPenerimaan:data.IDPenerimaan}), 
	    		(error, results, fields)=> {
					if(error){
						client.emit('penerimaan_paket_stream', error);
					}
					// set data yg mau dikirim
					var send = {
						type:"send",
						IDPenerimaan : data.IDPenerimaan,
						data
					};
					//emitt
					io.sockets.emit('penerimaan_paket_stream',send);
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
