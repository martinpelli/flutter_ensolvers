const  mongoose  = require('mongoose');
var folderModel =  require('../models/Folder');
var taskModel = require('../models/Task');

class TaskService{
    
    TaskService(){
        
    }

    async getTasks(){
        try{
            return await taskModel.find();
        }catch(error){
            return error;
        }
    }

    async createTask(folderId, task = new taskModel()){
        try{
            var savedTask;
            await taskModel.create(task).then((value) =>{
                savedTask = value;
            }).then(async () => {
                try{
                    await folderModel.updateOne(
                        { '_id': folderId }, { 
                            '$push': {
                                'tasks': savedTask['_id'].toString()} }
                    )
                }catch(error){
                    console.log(error);
                }
            });
            return savedTask;
        }catch(error){
            console.log(error);
        }
    }


    async deleteTask(idc){
        var deletedTask;
        try{
            await taskModel.findOneAndRemove({
                _id: idc
            }).then((value) => {
                deletedTask = value;
            });
            return deletedTask;
        }catch(error){
            console.log(error);
        }
    }

    async deleteTasks(){
        try{
            await taskModel.deleteMany();
        }catch(error){
            console.log(error);
        }
    }

    async modifyTask(newTask){
        var taskModified;
        try{
            await taskModel.findOneAndUpdate({
                _id: newTask._id
            }, newTask).then((value) =>{
                taskModified = value;
            })
            return taskModified;
        }catch (error){
            console.log(error);
        }
    }

    async deleteTasksInFolder (tasksIds){
        taskModel.deleteMany({ _id: { $in: tasksIds['tasksIds']}}, function(err) {}).clone();
    }

}

module.exports = new TaskService();
