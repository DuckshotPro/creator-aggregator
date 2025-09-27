const request = require('supertest');
const app = require('../index');

describe('Creator Aggregator API', () => {
  test('GET / should return app info', async () => {
    const response = await request(app).get('/');
    
    expect(response.status).toBe(200);
    expect(response.body.name).toBe('Creator Aggregator');
    expect(response.body.version).toBe('1.0.0');
    expect(response.body.endpoints).toHaveProperty('health');
    expect(response.body.endpoints).toHaveProperty('api');
  });

  test('GET /health should return health status', async () => {
    const response = await request(app).get('/health');
    
    expect(response.status).toBe(200);
    expect(response.body.status).toBe('ok');
    expect(response.body).toHaveProperty('timestamp');
    expect(response.body).toHaveProperty('uptime');
    expect(response.body.environment).toBeDefined();
  });

  test('GET /api should return 501 with available modules', async () => {
    const response = await request(app).get('/api');
    
    expect(response.status).toBe(501);
    expect(response.body.message).toContain('not yet implemented');
    expect(response.body.availableModules).toContain('instagram');
    expect(response.body.availableModules).toContain('snapchat');
  });

  test('GET /nonexistent should return 404', async () => {
    const response = await request(app).get('/nonexistent');
    
    expect(response.status).toBe(404);
    expect(response.body.error).toBe('Not Found');
  });
});