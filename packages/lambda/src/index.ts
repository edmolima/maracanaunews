export const handler = async (_event: unknown) => {
  return {
    statusCode: 200,
    body: JSON.stringify({ message: 'Hello from Lambda A!' }),
  };
};
