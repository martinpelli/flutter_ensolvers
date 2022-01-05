const { Schema, model } = require('mongoose');

new folderSchema = new Schema({
    title: String,
    key: String,
    tasks: Array
});

module.exports = model('Task', taskSchema);