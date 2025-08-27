let products = []; // In-memory product storage

exports.getProducts = (req, res) => {
  res.json(products);
};

exports.getProductById = (req, res) => {
  const { id } = req.params;
  const product = products.find(p => p.id === id);
  if (!product) return res.status(404).json({ message: 'Product not found' });
  res.json(product);
};

exports.createProduct = (req, res) => {
  const product = req.body;
  if (!product.id || !product.name) {
    return res.status(400).json({ message: 'Product ID and name are required' });
  }
  products.push(product);
  res.status(201).json(product);
};

exports.updateProduct = (req, res) => {
  const { id } = req.params;
  const index = products.findIndex(p => p.id === id);
  if (index === -1) return res.status(404).json({ message: 'Product not found' });

  products[index] = { ...products[index], ...req.body };
  res.json(products[index]);
};

exports.deleteProduct = (req, res) => {
  const { id } = req.params;
  const index = products.findIndex(p => p.id === id);
  if (index === -1) return res.status(404).json({ message: 'Product not found' });

  const deleted = products.splice(index, 1);
  res.json(deleted[0]);
};

