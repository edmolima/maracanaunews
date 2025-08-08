export const handler = async (event: unknown) => {
  try {
    console.log('[INFO] Worker triggered', { event });
    // Simulate work
    return {
      statusCode: 200,
      body: JSON.stringify({ message: 'Worker ran successfully' }),
    };
  } catch (err) {
    console.error('[ERROR] Worker failed', err);
    throw err;
  }
};
