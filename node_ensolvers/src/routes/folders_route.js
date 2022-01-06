const {Router} = require('express');
const {getFolders, createFolder, deleteFolder, deleteFolders, modifyFolder} = require('../controllers/folder_controller');
const router = Router();

router.get('/api/folders', getFolders);


router.post('/api/folders/create',createFolder);

router.delete('/api/folders/delete/:id', deleteFolder);

router.delete('/api/folders/delete/', deleteFolders);

router.put('/api/folders/modify', modifyFolder);

module.exports = router;