const mongoose = require('mongoose');


async function connect(){
    await mongoose.connect('mongodb+srv://adminUser:ensolvers@cluster0.1znr5.mongodb.net/myFirstDatabase?retryWrites=true&w=majority',{
        useNewUrlParser: true
    });
    console.log('Database: Connected');
};

module.exports = {connect};