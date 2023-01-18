package com.example.dart.repository;

import java.util.List;

import com.example.dart.model.Product;

public interface IProductRepository {
    public Product insert(Product product);
    public List<Product> getProduct();
    public Product update(int id, Product product);
    public Product delete(int id);
}
