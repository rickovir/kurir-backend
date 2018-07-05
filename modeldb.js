var mysql      = require('mysql');

module.exports = {
	connection:function(){
		return mysql.createConnection({
		  host     : 'localhost',
		  user     : 'root',
		  password : '',
		  database : 'kurir'
		});
	},
	insert: function(table, data)
	{                                               
		var lenData = Object.keys(data).length;
		// fetch value and data field
		var fieldData= '';
		var valueData= '';
		var i = 0;
		for(var key in data)
		{
			fieldData += key;
			valueData += "'"+data[key]+"'";
			i++;
			if(i != lenData){
				fieldData += ',';
				valueData += ',';
			}
		}
		return 'insert into '+table+' (' +fieldData+') values ('+valueData+')';
	},
	update: function(table, data, where)
	{
		var lenData = Object.keys(data).length;
		// fetch value and data field
		var valueData= '';
		var i = 0;
		for(var key in data)
		{
			valueData += key +" = "+"'"+data[key]+"'";
			i++;
			if(i != lenData){
				valueData += ',';
			}
		}
		var whereData = '';
		for(var key in where)
		{
			whereData += key +" = "+"'"+where[key]+"'";
		}

		return 'update '+table+' set ' +valueData+' where '+whereData;
	},
	findAll: function(table)
	{
		return `select * from ${table} where trash='N'`;
	},
	findDesc: function(table, idName)
	{
		return `select * from ${table} where trash='N' order by ${idName} desc`;
	},
	findWhere: function(table, where)
	{
		var lenData = Object.keys(where).length;
		// fetch value and data field
		var i = 0;
		var whereData = '';
		for(var key in where)
		{
			whereData += key +" = " + "'" +where[key]+ "'";
			i++;
			if(i != lenData){
				whereData += ' AND ';
			}
		}

		return `select * from ${table} where trash='N' AND ` + whereData;
	}
};