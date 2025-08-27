const express = require('express');
const app = express();
app.use(express.json());

// Routes
const userRoutes = require('./routes/users');
const productRoutes = require('./routes/products');
app.use('/api/users', userRoutes);
app.use('/api/products', productRoutes);

// Health check endpoint
app.get('/', (req, res) => res.send('API is running'));

// Start server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server started on port ${PORT}`));

