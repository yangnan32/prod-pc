package com.product.utils;

/**
 * Created by yangn on 2015/9/17.
 */
public class UiframeFileMsgVo {
    private String fileId;
    private String fileName;
    private Long fileSize;
    private String fileActionMsg;
    public String getFileId() {
        return fileId;
    }
    public void setFileId(String fileId) {
        this.fileId = fileId;
    }
    public String getFileName() {
        return fileName;
    }
    public void setFileName(String fileName) {
        this.fileName = fileName;
    }
    public Long getFileSize() {
        return fileSize;
    }
    public void setFileSize(Long fileSize) {
        this.fileSize = fileSize;
    }
    public String getFileActionMsg() {
        return fileActionMsg;
    }
    public void setFileActionMsg(String fileActionMsg) {
        this.fileActionMsg = fileActionMsg;
    }
}
