// make connection
var socket = io.connect('http://localhost:3000');

// Query DOM
var message = document.getElementById('message');
var handle = document.getElementById('handle');
var btn = document.getElementById('send');
var output = document.getElementById('output');

// emit events

btn.addEventListener("click", function(){
	socket.emit('chat',{
		message: message.value,
		handle:handle.value
	});

});


//listen for events
socket.on('chat', function(data){
	output.innerHTML += '<p><strong>'+data.handle+'</strong> : ' + data.message + '</p>';
});
// connecting
socket.on('connect', function(data) {
    socket.emit('show_paket');
});
socket.on('show_paket_messages', function(data) {
        // console.log(data);
        output.innerHTML+= JSON.stringify(data);
});
socket.on('paket_barang_stream', function(data) {
        console.log(data);
});

socket.on('penerimaan_paket_stream', function(data) {
        console.log(data);
        output.innerHTML+= JSON.stringify(data);
});


function testpaket(data){
	socket.emit('paket_barang_stream', data);
}
function penerimaan_paket(data){
	socket.emit('penerimaan_paket_stream', data);
}

function showpaket(){
	socket.emit('show_paket');
}
function getTime()
{
	return new Date().getTime();
}

function makeID(key)
{
	return key + getTime().toString();
}