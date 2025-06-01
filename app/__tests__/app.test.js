const { greeting } = require('../index');

test('greeting() returns the expected string', () => {
	expect(greeting()).toBe('Hello from URL-SAS!');
});
