const taskService = require('../services/task_service');

const getTasks = async(req, res) => {
    res.json({
        tasks: await taskService.getTasks()
    });
}

const createTask = async(req, res) =>{
    res.json({
        task: await taskService.createTask(req.params.id,req.body)
    });
}

const deleteTask = async(req, res) =>{
    res.json({
        task: await taskService.deleteTask(req.params.taskid,req.params.folderid)
    });
}

const deleteTasks = async(req, res) =>{
    res.json({
        task: await taskService.deleteTasks()
    });
}

const modifyTask = async(req, res) =>{
    res.json({
        task: await taskService.modifyTask(req.body)
    });
}

const deleteTasksInFolder = async(req, res) =>{
    res.json({
        tasks: await taskService.deleteTasksInFolder(req.body)
    });
}


module.exports = {getTasks, createTask, deleteTask, deleteTasks, modifyTask, deleteTasksInFolder};