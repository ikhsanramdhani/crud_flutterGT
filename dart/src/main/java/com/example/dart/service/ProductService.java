package com.example.dart.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.dart.model.Product;
import com.example.dart.repository.IProductRepository;

@Service
public class ProductService implements IProductService {

    @Autowired
    IProductRepository productRepository;

    @Override
    public Product insert(Product product) {
        // TODO Auto-generated method stub
        return productRepository.insert(product);
    }

    @Override
    public List<Product> getProduct() {
        // TODO Auto-generated method stub
        return productRepository.getProduct();
    }

    @Override
    public Product update(int id, Product product) {
        // TODO Auto-generated method stub
        return productRepository.update(id, product);
    }

    @Override
    public Product delete(int id) {
        // TODO Auto-generated method stub
        return productRepository.delete(id);
    }
    
}
