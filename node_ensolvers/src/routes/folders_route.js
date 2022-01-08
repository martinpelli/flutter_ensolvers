const {Router} = require('express');
const {getFolders, createFolder, deleteFolder, deleteFolders, modifyFolder, getTasksFromFolder} = require('../controllers/folder_controller');
const router = Router();

router.get('/api/folders', getFolders);

router.get('/api/folders/gettasks/:id', getTasksFromFolder);

router.post('/api/folders/create',createFolder);

router.delete('/api/folders/delete/:id', deleteFolder);

router.delete('/api/folders/deleteall/', deleteFolders);

router.put('/api/folders/modify', modifyFolder);

module.exports = router;