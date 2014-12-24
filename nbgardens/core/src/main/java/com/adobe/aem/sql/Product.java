package com.adobe.aem.sql;

//this bean holds the product information
public class Product {
	
	//define private class members
	private String productId;
	private String productName;
	private String productDescription;
	private String productQuantity;
	private String productCustomize;
	private String productCategory;
	
	public String getProductId() {
		return productId;
	}
	public void setProductId(String productId) {
		this.productId = productId;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getProductDescription() {
		return productDescription;
	}
	public void setProductDescription(String productDescription) {
		this.productDescription = productDescription;
	}
	public String getProductQuantity() {
		return productQuantity;
	}
	public void setProductQuantity(String productQuantity) {
		this.productQuantity = productQuantity;
	}
	public String getProductCustomize() {
		return productCustomize;
	}
	public void setProductCustomize(String productCustomize) {
		this.productCustomize = productCustomize;
	}
	public String getProductCategory() {
		return productCategory;
	}
	public void setProductCategory(String productCategory) {
		this.productCategory = productCategory;
	}
}
