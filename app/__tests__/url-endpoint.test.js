// url-endpoint.test.js
const request = require('supertest');
const { app } = require('../index'); // now index.js exports app

describe('/url endpoint', () => {
	test('GET /url responds with JSON containing greeting', async () => {
		const resp = await request(app).get('/url');
		expect(resp.statusCode).toBe(200);
		expect(resp.body).toEqual({ message: 'Hello from URL-SAS!' });
	});
});
