const {Router} = require('express');
const router = Router();
const Task = require('../models/Task');

router.get('/api/tasks', async (req,res) => {
    const tasks = await Task.find();
    res.json(
        {"serverName" : "Kid Cuddi",
         "tasks" : [
        tasks]
         });
});

router.get('/api/tasks/create', async (req, res) =>{
    for(let i=0; i<5; i++){
        await Task.create({
            title: "My Task",
            checked: false,
            key: "0"
        });
    }
    res.json({message: '5 tasks created'});
});

module.exports = router;