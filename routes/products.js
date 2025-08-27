const express = require('express');
const router = express.Router();
const { getProducts, createProduct, getProductById, updateProduct, deleteProduct } = require('../controllers/productController');

// Get all products
router.get('/', getProducts);

// Get a single product by ID
router.get('/:id', getProductById);

// Create a new product
router.post('/', createProduct);

// Update a product by ID
router.put('/:id', updateProduct);

// Delete a product by ID
router.delete('/:id', deleteProduct);

module.exports = router;

