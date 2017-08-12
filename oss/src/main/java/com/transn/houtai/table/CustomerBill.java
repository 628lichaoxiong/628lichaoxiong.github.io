package com.transn.houtai.table;


public class CustomerBill {
    private int id;

    private int customerId;

    private String company;

    private String identifier;

    private String address;

    private String mobile;

    private String bank;

    private String account;

    private int isdefault;

    public void setId(int id){
        this.id = id;
    }
    public int getId(){
        return this.id;
    }
    public void setCustomerId(int customerId){
        this.customerId = customerId;
    }
    public int getCustomerId(){
        return this.customerId;
    }
    public void setCompany(String company){
        this.company = company;
    }
    public String getCompany(){
        return this.company;
    }
    public void setIdentifier(String identifier){
        this.identifier = identifier;
    }
    public String getIdentifier(){
        return this.identifier;
    }
    public void setAddress(String address){
        this.address = address;
    }
    public String getAddress(){
        return this.address;
    }
    public void setMobile(String mobile){
        this.mobile = mobile;
    }
    public String getMobile(){
        return this.mobile;
    }
    public void setBank(String bank){
        this.bank = bank;
    }
    public String getBank(){
        return this.bank;
    }
    public void setAccount(String account){
        this.account = account;
    }
    public String getAccount(){
        return this.account;
    }
    public void setIsdefault(int isdefault){
        this.isdefault = isdefault;
    }
    public int getIsdefault(){
        return this.isdefault;
    }

}