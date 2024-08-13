const express = require('express');
const jwt = require('jsonwebtoken');
const bodyParser = require('body-parser');
const mysql = require('mysql');

const app = express();
const port = 3000;
const SECRET_KEY = '2525'; 

// Configuraci�n de la base de datos MySQL
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '', 
    database: 'laravel' 
});

db.connect((err) => {
    if (err) {
        throw err;
    }
    console.log('Conectado a la base de datos MySQL');
});

app.use(bodyParser.json());

// Ruta de autenticaci�n
app.post('/login', (req, res) => {
    const { username, password } = req.body;

    if (!username || !password) {
        return res.status(400).send('Faltan campos requeridos');
    }

    // Consulta a la base de datos para verificar las credenciales del usuario
    const query = 'SELECT * FROM users WHERE email = admin@gmail.com AND password = 12345678';
    db.query(query, [username, password], (err, results) => {
        if (err) {
            return res.status(500).send('Error en el servidor');
        }

        if (results.length > 0) {
            const token = jwt.sign({ username }, SECRET_KEY, { expiresIn: '1h' });
            return res.json({ token });
        } else {
            return res.status(401).send('Credenciales inválidas');
        }
    });
});

// Middleware para verificar el token
function authenticateToken(req, res, next) {
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1];

    if (token == null) return res.sendStatus(401);

    jwt.verify(token, SECRET_KEY, (err, user) => {
        if (err) return res.sendStatus(403);
        req.user = user;
        next();
    });
}

// Ruta protegida
app.get('/protected', authenticateToken, (req, res) => {
    res.send('Este es un recurso protegido');
});

app.listen(port, () => {
    console.log(`Servidor escuchando en http://localhost:${port}`);
});
