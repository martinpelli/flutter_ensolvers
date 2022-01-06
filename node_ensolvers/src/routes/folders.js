const {Router} = require('express');
const router = Router();
const Folder = require('../models/Folder');

router.get('/api/folders', async (req,res) => {
    const folders = await Folder.find();
    res.json(
        {"serverName" : "Kid Cuddi",
         "folders" : [
        folders]
         });
});

router.get('/api/folders/create', async (req, res) =>{
    for(let i=0; i<5; i++){
        await Folder.create({
            title: "My Folder",
            key: "0",
            tasks: [1]
        });
    }
    res.json({message: '5 folders created'});
});

module.exports = router;