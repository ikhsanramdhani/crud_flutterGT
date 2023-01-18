package com.example.dart.repository;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.example.dart.model.Product;

@Repository
public class ProductRepository implements IProductRepository{

    @Autowired
    JdbcTemplate jdbcTemplate;

    @Override
    public Product insert(Product product) {
        // TODO Auto-generated method stub
        var query = "INSERT INTO tb_product (name, price, qty) VALUES (?,?,?)";

        try {
            jdbcTemplate.update(query, new Object[] {
                product.getName(), product.getPrice(), product.getQty()
            });
            return product;
        } catch (Exception e) {
            // TODO: handle exception
            Product obj = new Product();
            return obj;
        }

    }

    @Override
    public List<Product> getProduct() {
        // TODO Auto-generated method stub
        var query = "SELECT * FROM tb_product";
        
        try {
            var result = jdbcTemplate.query(query, new BeanPropertyRowMapper<>(Product.class));
            return result;
        } catch (Exception e) {
            // TODO: handle exception
            List<Product> obj = new ArrayList<>();
            return obj;
        }

    }

    @Override
    public Product update(int id, Product product) {
        // TODO Auto-generated method stub
        var query = "UPDATE tb_product SET name = ?, price = ?, qty = ? WHERE id = ?";

        try {
            jdbcTemplate.update(query, new Object[] {
                product.getName(), product.getPrice(), product.getQty(),id
            });
            return product;
        } catch (Exception e) {
            // TODO: handle exception
            Product obj = new Product();
            return obj;
        }

    }

    @Override
    public Product delete(int id) {
        // TODO Auto-generated method stub

        var query = "SELECT * FROM tb_product WHERE id = ?";

        try {
            var result = jdbcTemplate.queryForObject(query, new BeanPropertyRowMapper<>(Product.class), id);

            query = "DELETE FROM tb_product WHERE id = ?";
            jdbcTemplate.update(query, id);

            return result;
        } catch (Exception e) {
            // TODO: handle exception
            Product obj = new Product();
            return obj;
        }

    }
    
}
