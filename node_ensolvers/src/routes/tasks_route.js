const {Router} = require('express');
const {getTasks, createTask, deleteTask, modifyTask} = require('../controllers/task_controller');
const router = Router();

router.get('/api/tasks', getTasks);

router.post('/api/tasks/create',createTask);

router.delete('/api/tasks/delete/:id', deleteTask);

router.put('/api/tasks/modify', modifyTask);

module.exports = router;