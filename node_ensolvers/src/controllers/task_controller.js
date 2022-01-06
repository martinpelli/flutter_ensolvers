const taskService = require('../services/task_service');

const getTasks = async(req, res) => {
    res.json({
        tasks: await taskService.getTasks()
    });
}

const createTask = async(req, res) =>{
    console.log(req.body);
    res.json({
        task: await taskService.createTask(req.body)
    });
}

const deleteTask = async(req, res) =>{
    res.json({
        task: await taskService.deleteTask(req.params.id)
    });
}

const modifyTask = async(req, res) =>{
    res.json({
        task: await taskService.modifyTask(req.body)
    });
}

module.exports = {getTasks, createTask, deleteTask,modifyTask};