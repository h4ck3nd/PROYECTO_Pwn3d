package model;

import java.sql.Timestamp;

public class Notice {
    private int id;
    private String vmName;
    private String date;
    private String creator;
    private String secondVmName;
    private String secondDate;
    private String secondCreator;
    private Timestamp createdNotice;
    private String descriptionPage;
    private String estado;

    // Constructor simple para insertar (sin id ni createdNotice)
    public Notice(String vmName, String date, String creator, String secondVmName, String secondDate, String secondCreator, String descriptionPage, String estado) {
        this.vmName = vmName;
        this.date = date;
        this.creator = creator;
        this.secondVmName = secondVmName;
        this.secondDate = secondDate;
        this.secondCreator = secondCreator;
        this.descriptionPage = descriptionPage;
        this.estado = estado;
    }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getVmName() {
		return vmName;
	}

	public void setVmName(String vmName) {
		this.vmName = vmName;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	public String getSecondVmName() {
		return secondVmName;
	}

	public void setSecondVmName(String secondVmName) {
		this.secondVmName = secondVmName;
	}

	public String getSecondDate() {
		return secondDate;
	}

	public void setSecondDate(String secondDate) {
		this.secondDate = secondDate;
	}

	public String getSecondCreator() {
		return secondCreator;
	}

	public void setSecondCreator(String secondCreator) {
		this.secondCreator = secondCreator;
	}

	public Timestamp getCreatedNotice() {
		return createdNotice;
	}

	public void setCreatedNotice(Timestamp createdNotice) {
		this.createdNotice = createdNotice;
	}

	public String getDescriptionPage() {
		return descriptionPage;
	}

	public void setDescriptionPage(String descriptionPage) {
		this.descriptionPage = descriptionPage;
	}

	public String getEstado() {
		return estado;
	}

	public void setEstado(String estado) {
		this.estado = estado;
	}
}
