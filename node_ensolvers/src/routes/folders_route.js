const {Router} = require('express');
const {getFolders, createFolder, deleteFolder} = require('../controllers/folder_controller');
const router = Router();

router.get('/api/folders', getFolders);

router.post('/api/folders/create',createFolder);

router.delete('/api/folders/delete/:id', deleteFolder);

module.exports = router;