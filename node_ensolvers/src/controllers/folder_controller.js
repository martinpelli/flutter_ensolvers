const folderService = require('../services/folder_service');

const getFolders = async(req, res) => {
    res.json({
        folders: await folderService.getFolders()
    });
}

const createFolder = async(req, res) =>{
    res.json({
        folder: await folderService.createFolder(req.body)
    });
}


const deleteFolder = async(req, res) =>{
    res.json({
        folder: await folderService.deleteFolder(req.params.id)
    });
}

const deleteFolders = async(req, res) =>{
    res.json({
        folder: await folderService.deleteFolders()
    });
}

const modifyFolder = async(req, res) =>{
    res.json({
        tasks: await folderService.modifyFolder(req.body)
    });
}


module.exports = {getFolders, createFolder, deleteFolder, deleteFolders, modifyFolder};