const express = require('express');
const app = express();
const morgan = require('morgan');
const cors = require('cors');

app.use(express.urlencoded({extended: true}));
app.use(express.json());
app.use(morgan('dev'));
app.use(cors());
app.use(require('./routes/folders_route'));
app.use(require('./routes/tasks_route'));



module.exports = app;