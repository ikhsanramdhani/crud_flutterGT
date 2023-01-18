package com.example.dart.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.example.dart.model.Product;
import com.example.dart.service.IProductService;

@RestController
@RequestMapping("/api/product")
public class ProductController {
    
    @Autowired
    IProductService productService;

    @PostMapping("/insert")
    public Product insert(@RequestBody Product product) {
        return productService.insert(product);
    }

    @GetMapping("/getProduct")
    public List<Product> getProduct() {
        return productService.getProduct();
    }

    @PutMapping("/update/{id}")
    public Product update(@PathVariable int id, @RequestBody Product product) {
        return productService.update(id, product);
    }

    @DeleteMapping("/delete/{id}")
    public Product delete(@PathVariable int id) {
        return productService.delete(id);
    }

}
