const Joi = require('joi');

module.exports = {
	validateCourse: function(course)
	{
		const schema = {
			name: Joi.string().min(3).required()
		}

		return Joi.validate(course, schema);
	},
	sum: function(n1,n2)
	{
		return n1+n2;
	}
}