const mongoose = require('mongoose');


async function connect(){
    await mongoose.connect('mongodb+srv://pelli:ensolvers@cluster0.t1nbc.mongodb.net/myFirstDatabase?retryWrites=true&w=majority',{
        useNewUrlParser: true
    });
    console.log('Database: Connected');
};

module.exports = {connect};