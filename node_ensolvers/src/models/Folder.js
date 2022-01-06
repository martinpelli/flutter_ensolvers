const { Schema, model } = require('mongoose');

const folderSchema = new Schema({
    title: String,
    tasks: Array

});

module.exports = model('Folder', folderSchema);