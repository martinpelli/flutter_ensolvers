const taskModel = require('../models/task');

class taskService{
    taskService(){}

    async getTasks(){
        try{
            return await taskModel.find();
        }catch(error){
            return error;
        }
    }

    async createTask(task = new taskModel()){
        try{
            var savedTask;
            await taskModel.create(task).then((value) =>{
                savedTask = value;
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

}

module.exports = new taskService();