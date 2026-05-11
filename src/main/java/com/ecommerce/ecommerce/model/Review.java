package com.ecommerce.ecommerce.model;

public class Review {

    private String username;
    private String comment;
    private int rating;
    private int productId;

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public Review(String username, String comment, int rating, int productId) {
        this.username = username;
        this.comment = comment;
        this.rating = rating;
        this.productId=productId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getComment() {
        return comment;
    }


    public int getRating() {
        return rating;
    }

}
