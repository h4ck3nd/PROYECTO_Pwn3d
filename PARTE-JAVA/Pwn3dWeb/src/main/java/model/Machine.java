package model;

public class Machine {
    private String id;
    private String nameMachine;
    private String size;
    private String os;
    private String enviroment;
    private String enviroment2;
    private String creator;
    private String difficultyCard;
    private String difficulty;
    private String date;
    private String md5;
    private String writeupUrl;
    private String firstUser;
    private String firstRoot;
    private String imgNameOs;
    private String downloadUrl;
    private String userFlag;
    private String rootFlag;

    // Constructor
    public Machine(String id, String nameMachine, String size, String os, String enviroment, String enviroment2, String creator,
            String difficultyCard, String difficulty, String date, String md5, String writeupUrl,
            String firstUser, String firstRoot, String imgNameOs, String downloadUrl,
            String userFlag, String rootFlag) {
	 this.id = id;
	 this.nameMachine = nameMachine;
	 this.size = size;
	 this.os = os;
	 this.enviroment = enviroment;
	 this.enviroment2 = enviroment2;
	 this.creator = creator;
	 this.difficultyCard = difficultyCard;
	 this.difficulty = difficulty;
	 this.date = date;
	 this.md5 = md5;
	 this.writeupUrl = writeupUrl;
	 this.firstUser = firstUser;
	 this.firstRoot = firstRoot;
	 this.imgNameOs = imgNameOs;
	 this.downloadUrl = downloadUrl;
	 this.userFlag = userFlag;
	 this.rootFlag = rootFlag;
	}
	
	// Getters y setters
	public String getUserFlag() {
	 return userFlag;
	}
	
	public void setUserFlag(String userFlag) {
	 this.userFlag = userFlag;
	}
	
	public String getRootFlag() {
	 return rootFlag;
	}
	
	public void setRootFlag(String rootFlag) {
	 this.rootFlag = rootFlag;
	}
	
    // Getters y setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNameMachine() {
        return nameMachine;
    }

    public void setNameMachine(String nameMachine) {
        this.nameMachine = nameMachine;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public String getOs() {
        return os;
    }

    public void setOs(String os) {
        this.os = os;
    }

    public String getEnviroment() {
        return enviroment;
    }

    public void setEnviroment(String enviroment) {
        this.enviroment = enviroment;
    }

    public String getEnviroment2() {
        return enviroment2;
    }

    public void setEnviroment2(String enviroment2) {
        this.enviroment2 = enviroment2;
    }

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator;
    }

    public String getDifficultyCard() {
        return difficultyCard;
    }

    public void setDifficultyCard(String difficultyCard) {
        this.difficultyCard = difficultyCard;
    }

    public String getDifficulty() {
        return difficulty;
    }

    public void setDifficulty(String difficulty) {
        this.difficulty = difficulty;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getMd5() {
        return md5;
    }

    public void setMd5(String md5) {
        this.md5 = md5;
    }

    public String getWriteupUrl() {
        return writeupUrl;
    }

    public void setWriteupUrl(String writeupUrl) {
        this.writeupUrl = writeupUrl;
    }

    public String getFirstUser() {
        return firstUser;
    }

    public void setFirstUser(String firstUser) {
        this.firstUser = firstUser;
    }

    public String getFirstRoot() {
        return firstRoot;
    }

    public void setFirstRoot(String firstRoot) {
        this.firstRoot = firstRoot;
    }

    public String getImgNameOs() {
        return imgNameOs;
    }

    public void setImgNameOs(String imgNameOs) {
        this.imgNameOs = imgNameOs;
    }

    public String getDownloadUrl() {
        return downloadUrl;
    }

    public void setDownloadUrl(String downloadUrl) {
        this.downloadUrl = downloadUrl;
    }
}
