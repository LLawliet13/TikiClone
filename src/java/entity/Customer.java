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
public class Customer {

    private int cid, status,csex;
    //int primary key identity(1,1),
    private String cname, cphone, cAddress, username,password , cdob, cemail;

    public Customer(int cid, int status, int csex, String cname, String cphone, String cAddress, String username, String password, String cdob, String cemail) {
        this.cid = cid;
        this.status = status;
        this.csex = csex;
        this.cname = cname;
        this.cphone = cphone;
        this.cAddress = cAddress;
        this.username = username;
        this.password = password;
        this.cdob = cdob;
        this.cemail = cemail;
    }

    public int getCid() {
        return cid;
    }

    public void setCid(int cid) {
        this.cid = cid;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getCsex() {
        return csex;
    }

    public void setCsex(int csex) {
        this.csex = csex;
    }

    public String getCname() {
        return cname;
    }

    public void setCname(String cname) {
        this.cname = cname;
    }

    public String getCphone() {
        return cphone;
    }

    public void setCphone(String cphone) {
        this.cphone = cphone;
    }

    public String getcAddress() {
        return cAddress;
    }

    public void setcAddress(String cAddress) {
        this.cAddress = cAddress;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getCdob() {
        return cdob;
    }

    public void setCdob(String cdob) {
        this.cdob = cdob;
    }

    public String getCemail() {
        return cemail;
    }

    public void setCemail(String cemail) {
        this.cemail = cemail;
    }

    

    
            
}
