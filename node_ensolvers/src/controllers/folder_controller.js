const folderService = require('../services/folder_service');

const getFolders = async(req, res) => {
    res.json({
        folders: await folderService.getFolders()
    });
}

const createFolder = async(req, res) =>{
    console.log(req.body);
    res.json({
        folder: await folderService.createFolder(req.body)
    });
}

const deleteFolder = async(req, res) =>{
    res.json({
        folder: await folderService.deleteFolder(req.params.id)
    });
}

module.exports = {getFolders, createFolder, deleteFolder};