const folderModel = require('../models/Folder');



class FolderService{
    FolderService(){}

    async getFolders(){
        try{
            return await folderModel.find();
        }catch(error){
            return error;
        }
    }

    async createFolder(folder = new folderModel()){
        try{
            var savedFolder;
            await folderModel.create(folder).then((value) =>{
                savedFolder = value;
            });
            return savedFolder;
        }catch(error){
            console.log(error);
        }
    }

    async deleteFolder(idc){
        var deletedFolder;
        try{
            await folderModel.findOneAndRemove({
                _id: idc
            }).then((value) => {
                deletedFolder = value;
            });
            return deletedFolder;
        }catch(error){
            console.log(error);
        }
    }

    async deleteFolders(){
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
            }, newFolder).then((value) =>{
                folderModified = value;
            })
            return folderModified;
        }catch (error){
            console.log(error);
        }
    }



}

module.exports = new FolderService();