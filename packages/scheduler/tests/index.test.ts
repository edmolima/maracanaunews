import { describe, it, expect } from 'vitest';
import { handler } from '../src';

describe('handler', () => {
  it('should return statusCode 200 and hello message', async () => {
    const result = await handler({});
    expect(result).toEqual({
      statusCode: 200,
      body: JSON.stringify({ message: 'Scheduler ran successfully' }),
    });
  });
});
