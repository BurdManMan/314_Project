const { get_name_from_db } = require('../src/database_example');

describe('get_name_from_db', () => {
  // Happy path - successful cases
  test('returns correct name for existing user', async () => {
    const name = await get_name_from_db(1);
    expect(name).toBe("Alice");
  });

  test('returns different name for different user', async () => {
    const name = await get_name_from_db(2);
    expect(name).toBe("Bob");
  });

  // Error cases
  test('throws error for non-existent user', async () => {
    await expect(get_name_from_db(999)).rejects.toThrow("User not found");
  });

  test('throws error for invalid user ID type', async () => {
    await expect(get_name_from_db("invalid")).rejects.toThrow();
  });
});