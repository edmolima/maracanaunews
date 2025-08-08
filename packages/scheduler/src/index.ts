export const handler = async (event: unknown) => {
  try {
    console.log('[INFO] Scheduler triggered', { event });
    // Simulate work
    return {
      statusCode: 200,
      body: JSON.stringify({ message: 'Scheduler ran successfully' }),
    };
  } catch (err) {
    console.error('[ERROR] Scheduler failed', err);
    throw err;
  }
};
