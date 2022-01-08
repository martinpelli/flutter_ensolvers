var folderModel =  require('../models/Folder');
var taskModel = require('../models/Task');

class FolderService{


    async getFolders()  {
        try{
            return await folderModel.find();
        }catch(error){
            return error;
        }
    }

    async getTasksFromFolder(folderId)  {
        try{
            return await folderModel.findById(folderId).then( async (tasksIds)  => {
                if(tasksIds['tasks'].length > 0){
                    var newTasksIds = this.castObjectIdToIds(tasksIds['tasks']);
                    return await taskModel.find({ '_id': { $in: newTasksIds } });
                }else{
                    return [];
                };
            }
         );

        }catch(error){
            return error;
        }
    }

     async createFolder(folder = new folderModel())  {
        try{
            var savedFolder;
            await folderModel.create(folder).then((value) => {
                savedFolder = value;
            });
            return savedFolder;
        }catch(error){
            console.log(error);
        }
    }

    async deleteFolder(idc) {
        var deletedFolder;
        try{
            await folderModel.findOneAndRemove({
                _id: idc
            }).then(async (folder) => {
                deletedFolder = folder;
                var tasksIds = this.castObjectIdToIds(folder['tasks']);
                await taskModel.deleteMany({ '_id': { $in: tasksIds } });
            });
            return deletedFolder;
        }catch(error){
            console.log(error);
        }
    }

    async deleteFolders() {
        try{
            await folderModel.deleteMany();
        }catch(error){
            console.log(error);
        }
    }

    async modifyFolder(newFolder){
        var folderModified;
        try{
            await folderModel.findOneAndUpdate({
                _id: newFolder._id
            }, newFolder).then((value) => {
                folderModified = value;
            })
            return folderModified;
        }catch (error){
            console.log(error);
        }
    }

    castObjectIdToIds(tasks){
        var newTasksIds = [tasks.length];
        for(var i = 0; i < tasks.length; i++){
            newTasksIds[i] = tasks[i].toString();
        }
        return newTasksIds;
    }

}

module.exports = new FolderService();