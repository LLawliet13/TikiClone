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
public class Product {

    private String pid, pname, image, description;

    int status, cateID, quantity;
    double price;

//    public Product(String pid, String pname, String image, String description, int status, int cateID, int quantity, int price) {
//        this.pid = pid;
//        this.pname = pname;
//        this.image = image;
//        this.description = description;
//        this.status = status;
//        this.cateID = cateID;
//        this.quantity = quantity;
//        this.price = price;
//    }
    public Product(String pid, String pname, String image, String description, int cateID, int quantity, double price, int status) {
        this.pid = pid;
        this.pname = pname;
        this.image = image;
        this.description = description;
        this.cateID = cateID;
        this.quantity = quantity;
        this.price = price;
        this.status = status;
    }

    public String getPid() {
        return pid;
    }

    public String getPname() {
        return pname;
    }

    public int getQuantity() {
        return quantity;
    }

    public double getPrice() {
        return price;
    }

    public String getImage() {
        return image;
    }

    public String getDescription() {
        return description;
    }

    public int getStatus() {
        return status;
    }

    public int getCateID() {
        return cateID;

    }

    public void setPid(String pid) {
        this.pid = pid;
    }

    public void setPname(String pname) {
        this.pname = pname;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public void setCateID(int cateID) {
        this.cateID = cateID;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    @Override
    public String toString() {
        return "Product{" + "pid=" + pid + ", pname=" + pname + ", image=" + image + ", description=" + description + ", status=" + status + ", cateID=" + cateID + ", quantity=" + quantity + ", price=" + price + '}';
    }

}
