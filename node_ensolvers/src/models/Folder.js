const { Schema, model } = require('mongoose');

const folderSchema = new Schema({
    title: String,
    key: String,
    tasks: Array

});

module.exports = model('Folder', folderSchema);