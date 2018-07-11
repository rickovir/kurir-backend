
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

// app.get('/api/connect/',(req, res)=>{
// 	con.query(db.findAll("cabang"),	
// 		(error, results, fields)=> {
// 			if(error)
// 				throw error;
// 			res.send(results);
// 		});
// });

io.on('connection', function(client){
	console.log('made socket connection ', client.id)

	client.on('chat', function(data){
		io.sockets.emit('chat',data)
	});
    // to give servers request
	client.on('servers_stream', function(data) {
        console.log(data);
	        con.query(db.findAll("cabang"), (error, results, fields)=>{
				if(error)
					throw error;
	        	client.emit('servers_stream', results);
			});
    });

	// to give packet_barang request
	client.on('show_paket_barang', function(data) {
        console.log(data);
        var sql = `select * from paket_barang where trash = 'N' AND isSyn = 'N' order by IDPaket desc`;
        con.query(sql, (error, results, fields)=>{
			if(error)
				throw error;
        	client.emit('show_paket_messages', results);
		});
    });

	client.on('show_kurir', function(data) {
        console.log(data);
	        con.query(db.findDesc("kurir", "IDKurir"), (error, results, fields)=>{
				if(error)
					throw error;
	        	client.emit('show_kurir_messages', results);
			});
    });

	client.on('show_kurir_motor', function(data) {
        console.log(data);
        var sql = `select * from kurir where trash='N' and jenis='MTR' order by IDKurir desc`;
	        con.query(sql, (error, results, fields)=>{
				if(error)
					throw error;
	        	client.emit('show_kurir_motor_messages', results);
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

	client.on('select_kurir', function(data) {
        console.log(data);
	        con.query(db.findWhere("kurir", data), (error, results, fields)=>{
				if(error)
					throw error;
				var kurir = results;

		        con.query(db.findWhere("penempatan_detail", data), (error, results, fields)=>{
					if(error)
						throw error;
					var penempatan_detail = results;
		        	client.emit('select_kurir_messages', {kurir,penempatan_detail});
		        });
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
    // to give show_list_pengiriman_besar
	client.on('show_list_pengiriman_besar', function(data) {
        console.log(data);
	        con.query(db.findDesc("list_pengiriman_besar", "IDListPengirimanBesar"), (error, results, fields)=>{
				if(error)
					throw error;
	        	client.emit('list_pengiriman_besar_messages', results);
			});
    });
    // to give show_list_pengiriman
	client.on('show_list_pengiriman_motor', function(data) {
        console.log(data);
        var sql = `SELECT kurir.IDKurir, count(list_pengiriman.IDPengiriman) as jumlah from kurir, list_pengiriman WHERE kurir.IDKurir=list_pengiriman.IDKurir and kurir.jenis = 'MTR' and list_pengiriman.trash = 'N' GROUP BY IDKurir ORDER by kurir.IDKurir DESC`;
	        con.query(sql , (error, results, fields)=>{
				if(error)
					throw error;
	        	client.emit('show_list_pengiriman_motor_messages', results);
			});
    });
    // to give cabang request
	client.on('show_cabang_list', function(data) {
        console.log(data);
        var sql = `select * from cabang where IDCabang not in (${data})`;
	        con.query(sql, (error, results, fields)=>{
				if(error)
					throw error;
	        	client.emit('show_cabang_list_messages', results);
			});
    });
    // to give paket for list pengiriman besar request
	client.on('show_paket_list', function(data) {
        console.log(data);
	        con.query(db.findWhere("paket_barang", {IDCabang:data, isSyn:'N'}), (error, results, fields)=>{
				if(error)
					throw error;
	        	client.emit('show_paket_list_messages', results);
			});
    });
    // to give paket for list pengiriman request
	client.on('show_paket_pengiriman', function(data) {
        console.log(data);
        var sql = `SELECT 
	DISTINCT paket_barang.* 
    from 
    	paket_barang
    WHERE 
    	paket_barang.IDPaket NOT IN
        (
            SELECT 
            	list_pengiriman.IDPaket
            from 
            	list_pengiriman,
            	paket_barang
            where
            	list_pengiriman.IDPaket = paket_barang.IDPaket
            and 
                list_pengiriman.trash = 'N' 
        ) 
    and 
    	paket_barang.IDCabang=${data} 
    ORDER by 
    	paket_barang.IDPaket DESC;`;
	        con.query(sql, (error, results, fields)=>{
				if(error)
					throw error;
	        	client.emit('show_paket_pengiriman_messages', results);
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
					list_pengiriman.IDKurir = ${data.IDKurir} and list_pengiriman.trash ='N'`;
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
    	
    	if(data.type == "add")
    	{
    		var list = data.list;
    		var data = new Array(list.length);
					
			for(var i=0; i<list.length; i++)
			{
				data[i] = new Array(9);
				data[i][0] = 0;
				data[i][1] = list[i].IDKurir;
				data[i][2] = list[i].IDCabang;
				data[i][3] = list[i].IDPaket;
				data[i][4] = list[i].prioritas;
				data[i][5] = list[i].kategori_paket;
				data[i][6] = getTime().toString();
				data[i][7] = getTime().toString();
				data[i][8] = getTime().toString();
			}
			var sql = `insert into list_pengiriman(
						IDPengiriman, 
						IDKurir,
						IDCabang,
						IDPaket,
						prioritas,
						kategori_paket,
						created_on,
						waktu_mulai,
						waktu_selesai
						)
						values ?
						`;
			// jalankan query
			console.log(sql);
			con.query(sql, [data] , 
				(error, results, fields)=> {
					if(error)
					{
						client.emit('list_pengiriman_stream', error);
					}
					var send = {
						type:"add",
						data
					}
					// emittt
					io.sockets.emit('list_pengiriman_stream',send);

				});
    	}
    	else if(data.type=="ubah_status")
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
    	else if(data.type=="delete")
    	{
    		// console.log(data.id);
    		// client.emit('list_pengiriman_stream', data.id);
	    	con.query(db.update("list_pengiriman",{trash:"Y"},{IDPengiriman:data.IDPengiriman}), 
    		(error, results, fields)=> {
				if(error){
					client.emit('list_pengiriman_stream', error);
				}
				// set data yg mau dikirim
				var send = {
					type:"delete",
					IDPengiriman:data.IDPengiriman,
					sql :db.update("list_pengiriman",{trash:"Y"},{IDPengiriman:data.IDPengiriman})
				};
				//emitt
				io.sockets.emit('list_pengiriman_stream', send);
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
    	//get data cabang first
    	var cabang = data.cabang;

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
			    		detail : `Barang telah diterima di Cabang ${cabang.nama_cabang}`
					};

					con.query(db.insert("log_tracking", sendLog) ,
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
						IDCabang : cabang.IDCabang,
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
    });
	client.on('kurir_stream', function(data){
		console.log(data);
		if(data.type == "add")
		{	
	    	var cabang = data.cabang;
	    	var penempatan = data.dataPenempatan;
			//set data yang akan di insert
	    	var data = {
	    		nama_kurir: data.data.nama_kurir,
	    		password: data.data.password,
	    		telepon: data.data.telepon,
	    		alamat: data.data.alamat,
	    		jenis: data.data.jenis,
	    		created_on: getTime().toString()
	    	};

	    	// jalankan query
	    	con.query(db.insert("kurir", data) , 
	    		(error, results, fields)=> {
					if(error)
					{
						client.emit('kurir_stream', error);
					}					// set data yg mau dikirim
					var send = {
						type:"add",
						IDKurir : results.insertId,
						data
					}
					// emittt
					io.sockets.emit('kurir_stream',send);
					// set data yg mau dikirim
					var dataPenempatan = {
						IDKurir : results.insertId,
						IDCabang : cabang.IDCabang,
						deskripsi_lokasi : penempatan.alamat_penempatan,
						latitude : penempatan.lat,
						longitude : penempatan.lng,
						created_on : getTime().toString()
					};

					con.query(db.insert("penempatan_detail", dataPenempatan),
		    		(error, results, fields)=> {
						if(error)
						{
							client.emit('kurir_stream', error);
						}
						console.log("penempatan_detail berhasil ditambah");
					});
				});
		    }
		    else if(data.type == "update")
		    {
		    	var cabang = data.cabang;
	    		var penempatan = data.dataPenempatan;
	    		var id = data.IDKurir;
				//set data yang akan di update
		    	var data = {
		    		nama_kurir: data.data.nama_kurir,
		    		password: data.data.password,
		    		telepon: data.data.telepon,
		    		alamat: data.data.alamat,
		    		jenis: data.data.jenis
		    	};
		    	con.query(db.update("kurir",data,{IDKurir:id}), 
		    		(error, results, fields)=> {
						if(error)
						{
							client.emit('kurir_stream', error);
						}

		    			var send = {
		    				type:"update",
		    				IDKurir : id,
		    				data
		    			}
						io.sockets.emit('kurir_stream',send);

		    			var dataPenempatan = {
							IDKurir : id,
							IDCabang : cabang.IDCabang,
							deskripsi_lokasi : penempatan.alamat_penempatan,
							latitude : penempatan.lat,
							longitude : penempatan.lng
		    			}
	    				con.query(db.update("penempatan_detail",dataPenempatan,{IDKurir:id}), 
				    		(error, results, fields)=> {
								if(error)
								{
									client.emit('kurir_stream', error);
								}
								console.log("penempatan_detail berhasil diubah");
							});
		    		});
		    }
		    else if(data.type == "delete")
		    {
		    	con.query(db.update("kurir",{trash:"Y"},{IDKurir:data.IDKurir}), 
		    		(error, results, fields)=> {
						if(error){
							client.emit('kurir_stream', error);
						}
						// set data yg mau dikirim
						var send = {
							type:"delete",
							IDKurir : data.IDKurir
						};
						//emitt
						io.sockets.emit('kurir_stream', send);
						con.query(db.update("kurir",{trash:"Y"},{IDKurir:data.IDKurir}), 
				    		(error, results, fields)=> {
								if(error){
									client.emit('kurir_stream', error);
								}
								console.log("penempatan_detail berhasil didelete")
							});
					});

		    }
		});
	client.on('list_pengiriman_besar_stream', function(data){
		console.log(data);
		if(data.type == "add")
		{
			var detail = data.detail;
			var IDKurir = data.list.IDKurir;
			var IDCabangTujuan = data.list.IDCabangTujuan;
			var dataList = {
				IDKurir : data.list.IDKurir,
				IDCabangTujuan : data.list.IDCabangTujuan,
				IDCabangAsal : data.list.IDCabangAsal,
				isSend : data.list.isSend,
				created_on : getTime().toString(),
				isCancel : data.list.isCancel
			};
			// jalankan query
	    	con.query(db.insert("list_pengiriman_besar", dataList) , 
	    		(error, results, fields)=> {
					if(error)
					{
						client.emit('list_pengiriman_besar_stream', error);
					}	
					// set data yg mau dikirim
					var send = {
						type:"add",
						IDListPengirimanBesar : results.insertId,
						data : dataList
					}
					console.log(send);

					// emittt
					io.sockets.emit('list_pengiriman_besar_stream',send);

					var data = new Array(detail.length);
					
					for(var i=0; i<detail.length; i++)
					{
						data[i] = new Array(4);
						data[i][0] = 0;
						data[i][1] = results.insertId;
						data[i][2] = detail[i].IDPaket;
						data[i][3] = getTime().toString();
					}

					var sql = `insert into detail_pengiriman_besar(
						IDDetailPengirimanBesar, 
						IDListPengirimanBesar,
						IDPaket,
						created_on
						)
						values ?
						`;
						console.log(sql);
					con.query(sql, [data] , 
			    		(error, results, fields)=> {
							if(error)
							{
								client.emit('list_pengiriman_besar_stream', error);
							}
							console.log("detail_pengiriman_besar oke ");

							// update paketBarang
							// var sqlPaket = '';
							for(var i =0; i<detail.length; i++)
							{
								var sqlPaket = `update paket_barang set isSyn ='Y' where IDPaket = ${detail[i].IDPaket}`;

								con.query(sqlPaket,(error, results, fields)=> {
									if(error)
									{
										client.emit('list_pengiriman_besar_stream', error);
									}

									console.log("update barang oke ");
								});
							}

							var dataLog = new Array(detail.length);
							
							for(var i=0; i<detail.length; i++)
							{
								dataLog[i] = new Array(3);
								dataLog[i][0] = detail[i].IDPaket;
								dataLog[i][1] = `Barang sedang dalam pengiriman oleh ${ IDKurir } menuju cabang ${IDCabangTujuan}`;
								dataLog[i][2] = getTime().toString();
							}
							var sql = `insert into log_tracking(
								IDPaket, 
								detail,
								created_on
								)
								values ?
								`;
								console.log(sql);
								client.emit('list_pengiriman_besar_stream', sql);
							con.query(sql, [dataLog] , 
					    		(error, results, fields)=> {
									if(error)
									{
										client.emit('list_pengiriman_besar_stream', error);
									};
								console.log("Log barang oke to insert ");
							});
						});
				});
		}
		else if(data.type=="batal")
		{
			var dataID = data.data;

	    	con.query(db.update("list_pengiriman_besar",{ isCancel:'Y' },dataID), 
	    		(error, results, fields)=> {
	    			if(error)
					{
						client.emit('list_pengiriman_besar_stream', error);
					}

			    	var send = {
			    		type:"batal",
			    		dataID
			    	};
					io.sockets.emit('list_pengiriman_besar_stream',send);
					var sql = `select * from detail_pengiriman_besar where IDListPengirimanBesar= ${dataID.IDListPengirimanBesar} and trash='N'`;
					con.query(sql,
						(error, results, fields)=> {
			    			if(error)
							{
								client.emit('list_pengiriman_besar_stream', error);
							}

							for(var i=0; i<results.length;i++)
							{
								console.log(results[i]);
								var sqlUp = `update paket_barang set isSyn = 'N' where IDPaket =${results[i].IDPaket} and trash='N'`;
								con.query(sqlUp,
									(error, results, fields)=> {
						    			if(error)
										{
											client.emit('list_pengiriman_besar_stream', error);
										}
										console.log(sqlUp);
									});
								}
						});
	    		});
		}
	});
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
