// Mock database function (in real app, this would connect to a real DB)
async function get_name_from_db(userId) {
    // In a real app, this would query your database
    const mockDb = {
      1: "Alice",
      2: "Bob",
      3: "Charlie"
    };
    
    if (!mockDb[userId]) {
      throw new Error("User not found");
    }
    
    return mockDb[userId];
  }
  
  module.exports = { get_name_from_db };