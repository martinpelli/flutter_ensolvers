const {Router} = require('express');
const router = Router();

router.get('/api/folders', (req,res) => {
    res.json('Folder list');
});

router.get('/api/folders/create', (req, res) =>{
    res.json({message: '5 folders created'});
});

module.exports = router;