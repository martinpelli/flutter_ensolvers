const {Router} = require('express');
const {getTasks, createTask, deleteTask, modifyTask, deleteTasks, deleteTasksInFolder} = require('../controllers/task_controller');
const router = Router();

router.get('/api/tasks', getTasks);

router.post('/api/tasks/create/:id',createTask);

router.delete('/api/tasks/delete/:taskid/:folderid', deleteTask);

router.delete('/api/tasks/delete/', deleteTasksInFolder);

router.delete('/api/tasks/deleteAll/', deleteTasks);

router.put('/api/tasks/modify', modifyTask);

module.exports = router;