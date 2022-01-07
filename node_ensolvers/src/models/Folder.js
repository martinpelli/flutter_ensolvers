const { Schema, model } = require('mongoose');

const folderSchema = new Schema({
    title: String,
    tasks: [{type: Schema.Types.ObjectId, ref: 'Task'}]

});


module.exports = model('Folder', folderSchema);