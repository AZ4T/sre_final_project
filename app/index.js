// index.js
const express = require('express');
const client = require('prom-client');

const app = express();
const register = new client.Registry();

// Basic HTTP request duration histogram (you can omit if you don't need it for this test)
const httpDuration = new client.Histogram({
	name: 'http_request_duration_seconds',
	help: 'Duration of HTTP requests',
	labelNames: ['method', 'route', 'status_code'],
});
register.registerMetric(httpDuration);
client.collectDefaultMetrics({ register });

app.use((req, res, next) => {
	const end = httpDuration.startTimer();
	res.on('finish', () => {
		end({
			method: req.method,
			route: req.path,
			status_code: res.statusCode,
		});
	});
	next();
});

// A small helper we can test with Jest
function greeting() {
	return 'Hello from URL-SAS!';
}

// Example route that uses that helper
app.get('/url', (req, res) => {
	res.json({ message: greeting() });
});

// Expose /metrics (Prometheus)
app.get('/metrics', async (req, res) => {
	res.set('Content-Type', register.contentType);
	res.end(await register.metrics());
});

const PORT = 8080;

// Only start listening if this file is run directly.
// When Jest does `require('./index')`, require.main !== module, so it won't start the server.
if (require.main === module) {
	app.listen(PORT, () => {
		console.log(`URL-SAS listening on port ${PORT}`);
	});
}

// Export the greeting() function (and optionally the Express app, if you ever want to test routes)
module.exports = {
	greeting,
	app, // you could export the entire app if you want to write supertest‐based tests
};
