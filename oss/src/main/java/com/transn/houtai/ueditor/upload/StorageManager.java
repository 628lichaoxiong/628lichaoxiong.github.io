package com.transn.houtai.ueditor.upload;


import com.transn.houtai.ueditor.define.AppInfo;
import com.transn.houtai.ueditor.define.BaseState;
import com.transn.houtai.ueditor.define.State;
import com.transn.houtai.util.qiniu;

import org.apache.commons.io.FileUtils;

import java.io.*;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;

public class StorageManager {

    public static final int BUFFER_SIZE = 8192;

    public StorageManager() {
    }

    public static State saveBinaryFile(byte[] data, String path) {
        File file = new File(path);

        State state = valid(file);

        if (!state.isSuccess()) {
            return state;
        }

        // 上传到七牛云存储 Start
        try {
        	String fileName = file.getName();
    	    String fileType = fileName.substring(fileName.lastIndexOf("."));
    	    String randomUUID = UUID.randomUUID().toString();
    	    String newFilepath = randomUUID+fileType;
            qiniu.updateFile(file, newFilepath);
		} catch (Exception e) {
			Logger.getLogger(StorageManager.class.getName()).log(Level.SEVERE, null, e);
            return new BaseState(false, AppInfo.IO_ERROR);
		}
        // 上传到七牛云存储 End
        state = new BaseState(true, file.getAbsolutePath());
        state.putInfo("size", data.length);
        state.putInfo("title", file.getName());
        return state;
    }

    public static State saveFileByInputStream(InputStream is, String path,
            long maxSize,String savePath) {
        State state = null;

        File tmpFile = getTmpFile();

        byte[] dataBuf = new byte[2048];
        BufferedInputStream bis = new BufferedInputStream(is, StorageManager.BUFFER_SIZE);

        try {
            BufferedOutputStream bos = new BufferedOutputStream(
                    new FileOutputStream(tmpFile), StorageManager.BUFFER_SIZE);

            int count = 0;
            while ((count = bis.read(dataBuf)) != -1) {
                bos.write(dataBuf, 0, count);
            }
            bos.flush();
            bos.close();

            if (tmpFile.length() > maxSize) {
                tmpFile.delete();
                return new BaseState(false, AppInfo.MAX_SIZE);
            }

            state = saveTmpFile(tmpFile, path,savePath);

            if (!state.isSuccess()) {
                tmpFile.delete();
            }

            return state;

        } catch (IOException e) {
        }
        return new BaseState(false, AppInfo.IO_ERROR);
    }

    public static State saveFileByInputStream(InputStream is, String path,String savePath) {
        State state = null;

        File tmpFile = getTmpFile();

        byte[] dataBuf = new byte[2048];
        BufferedInputStream bis = new BufferedInputStream(is, StorageManager.BUFFER_SIZE);

        try {
            BufferedOutputStream bos = new BufferedOutputStream(
                    new FileOutputStream(tmpFile), StorageManager.BUFFER_SIZE);

            int count = 0;
            while ((count = bis.read(dataBuf)) != -1) {
                bos.write(dataBuf, 0, count);
            }
            bos.flush();
            bos.close();

            state = saveTmpFile(tmpFile, path,savePath);

            if (!state.isSuccess()) {
                tmpFile.delete();
            }

            return state;
        } catch (IOException e) {
        }
        return new BaseState(false, AppInfo.IO_ERROR);
    }

    private static File getTmpFile() {
        File tmpDir = FileUtils.getTempDirectory();
        String tmpFileName = (Math.random() * 10000 + "").replace(".", "");
        return new File(tmpDir, tmpFileName);
    }

    public static State saveTmpFile(File tmpFile, String path,String savePath) {
        State state = null;
        // 上传到七牛云存储 Start
        File tempFile = new File(path.trim());
        try {
            qiniu.updateFile(tmpFile, savePath);
		} catch (Exception e) {
			Logger.getLogger(StorageManager.class.getName()).log(Level.SEVERE, null, e);
            return new BaseState(false, AppInfo.IO_ERROR);
		}
        // 上传到七牛云存储 End
        state = new BaseState(true);
        state.putInfo("size", tmpFile.length());
        state.putInfo("title", tempFile.getName());

        return state;
    }

    private static State valid(File file) {
        File parentPath = file.getParentFile();

        if ((!parentPath.exists()) && (!parentPath.mkdirs())) {
            return new BaseState(false, AppInfo.FAILED_CREATE_FILE);
        }

        if (!parentPath.canWrite()) {
            return new BaseState(false, AppInfo.PERMISSION_DENIED);
        }

        return new BaseState(true);
    }
}
