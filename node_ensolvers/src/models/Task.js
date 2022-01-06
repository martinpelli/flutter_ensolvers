const { Schema, model } = require('mongoose');

const taskSchema = new Schema({
    title: String,
    checked: Boolean
});

module.exports = model('Task', taskSchema);