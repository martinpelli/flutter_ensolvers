const { Schema, model } = require('mongoose');

const taskSchema = new Schema({
    title: String,
    checked: Boolean,
    key: String
});

module.exports = model('Task', taskSchema);