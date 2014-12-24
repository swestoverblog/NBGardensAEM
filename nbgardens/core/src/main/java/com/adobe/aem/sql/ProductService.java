package com.adobe.aem.sql;

public interface ProductService {
	
	 //Adds a new product record in the Product table
    public int injestProdData(String name, String description, String quantity, String customize, String category);
       
    /*
     * Retrieves product data from the Product table and returns all product
     *The filter argument specifies one of the following values:
     *    
     *Product - retrieves all product data
     *Active Product- retrieves current products
     *Past Product - retrieves old products no longer current products
     */
    public String getProductData(String filter); 

}
