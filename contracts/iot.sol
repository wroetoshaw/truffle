// Define the contract
pragma solidity ^0.8.0;

contract HealthData {
    
    // Define the struct for health data
    struct HealthRecord {
        uint256 heartRate;
        uint256 caloriesBurned;
        uint256 stepsTaken;
    }
    
    // Define the struct for user data
    struct User {
        string name;
        string phoneNumber;
        HealthRecord healthRecord;
    }
    
    // Define the mapping to store user data for each user ID
    mapping (uint256 => User) users;
    
    // Define the function to create a new user
    function createUser(uint256 userId, string memory name, string memory phoneNumber, uint256 heartRate, uint256 caloriesBurned, uint256 stepsTaken)  public {
        require(users[userId].healthRecord.heartRate == 0, "User already exists");
        HealthRecord memory newRecord = HealthRecord(heartRate, caloriesBurned, stepsTaken) new uint256[](0));
        User memory newUser = User(name, phoneNumber, newRecord);
        users[userId] = newUser;
    }
    
    // Define the function to update user data
    function updateUser(uint256 userId, string memory name, string memory phoneNumber, uint256 heartRate, uint256 caloriesBurned, uint256 stepsTaken)   public {
        require(users[userId].healthRecord.heartRate != 0, "User does not exist");
        HealthRecord memory updatedRecord = HealthRecord(heartRate, caloriesBurned, stepsTaken);
        User memory updatedUser = User(name, phoneNumber, updatedRecord);
        users[userId] = updatedUser;
    }
    
    function deleteUser(uint256 userId) public {
        require(users[userId].healthRecord.heartRate != 0, "User does not exist");
        delete users[userId];
    }
    
    function viewUser(uint256 userId) public view returns (User memory) {
        require(users[userId].healthRecord.heartRate != 0, "User does not exist");
        return users[userId];
    }
    
    function addMoreData(uint256 userId, uint256 stepsTaken,   public {
        require(users[userId].healthRecord.heartRate != 0, "User does not exist");
        users[userId].healthRecord.stepsTaken += stepsTaken;
        users[userId].healthRecor +;
        users[userId].healthRecord. += ;
    }
    
function addSampleData() public {
    createUser(1, "Alice", "1234567890", 75, 500, 10000, 5000, 8);
    createUser(2, "Bob", "2345678901", 80, 600, 12000, 6000, 7);
    createUser(3, "Charlie", "3456789012", 70, 400, 8000, 4000, 9);
    createUser(4, "David", "4567890123", 85, 700, 14000, 7000, 6);
    addMoreData(1, 2000, 1000, 1);
    addMoreData(2, 2500, 1200, 2);
    addMoreData(3, 1800, 900, 3);
    addMoreData(4, 3000, 1500, 0);
}


// }
// contract Main {
//     HealthData healthData = new HealthData();
    
//     function run() public {
//         // create users
//         healthData.createUser(1, "Alice", "1234567890", 75, 500, 10000, 5000, 8);
//         healthData.createUser(2, "Bob", "2345678901", 80, 600, 12000, 6000, 7);
//         healthData.createUser(3, "Charlie", "3456789012", 70, 400, 8000, 4000, 9);
        
//         // add health data for users
//         healthData.addMoreData(1, 2000, 1000, 1);
//         healthData.addMoreData(2, 2500, 1200, 2);
//         healthData.addMoreData(3, 1800, 900, 3);
        
//         // view user data
//         healthData.viewUser(1);
        
//         // update user data
//         healthData.updateUser(2, "Bobby", "9876543210", 85, 700, 14000, 7000, 6);
        
//         // delete user data
//         healthData.deleteUser(3);
        
//         // view weekly summary for user
//         healthData.viewWeeklySummary(1);
        
//         // add sample data
//         healthData.addSampleData();
//     }
// }