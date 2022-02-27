/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

/**
 *
 * @author DELL
 */
public class Bill {

    String oID, dateCreate, cname, cphone, cAddress;
    double total;
    int status, cid;

    public Bill(String oID, String cname, String cphone, String cAddress, double total, int cid) {
        this.oID = oID;
        this.cname = cname;
        this.cphone = cphone;
        this.cAddress = cAddress;
        this.total = total;
        this.cid = cid;
    }

    public Bill(String oID, String dateCreate, String cname, String cphone, String cAddress, double total, int status, int cid) {
        this.oID = oID;
        this.dateCreate = dateCreate;
        this.cname = cname;
        this.cphone = cphone;
        this.cAddress = cAddress;
        this.total = total;
        this.status = status;
        this.cid = cid;
    }


    
//
//    public Bill(String oID, String dateCreate, String cname, String cphone, String cAddress, String total, int cid) {
//        this.oID = oID;
//        this.dateCreate = dateCreate;
//        this.cname = cname;
//        this.cphone = cphone;
//        this.cAddress = cAddress;
//        this.total = total;
//        this.cid = cid;
//    }
    
    public String getoID() {
        return oID;
    }

    public String getDateCreate() {
        return dateCreate;
    }

    public void setoID(String oID) {
        this.oID = oID;
    }

    public void setDateCreate(String dateCreate) {
        this.dateCreate = dateCreate;
    }

    public void setCname(String cname) {
        this.cname = cname;
    }

    public void setCphone(String cphone) {
        this.cphone = cphone;
    }

    public void setcAddress(String cAddress) {
        this.cAddress = cAddress;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public void setCid(int cid) {
        this.cid = cid;
    }

    public String getCname() {
        return cname;
    }

    public String getCphone() {
        return cphone;
    }

    public String getcAddress() {
        return cAddress;
    }

    public double getTotal() {
        return total;
    }

    public int getStatus() {
        return status;
    }

    public int getCid() {
        return cid;
    }
    
}
