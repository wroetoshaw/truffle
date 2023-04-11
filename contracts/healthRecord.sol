// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HealthRecords {

    struct Record {
        address patient;
        string name;
        uint256 birthdate;
        string condition;
        string treatment;
        bool isPublic;
    }

    mapping (uint256 => Record) private records;
    mapping (address => uint256[]) private patientRecords;

    uint256 private recordCount;

    event NewRecord(address indexed patient, uint256 indexed recordId);

    function addRecord(string memory _name, uint256 _birthdate, string memory _condition, string memory _treatment, bool _isPublic) public {
        require(_birthdate > 0, "Invalid birthdate");
        require(bytes(_name).length > 0, "Invalid name");
        require(bytes(_condition).length > 0, "Invalid condition");
        require(bytes(_treatment).length > 0, "Invalid treatment");

        Record memory newRecord = Record(msg.sender, _name, _birthdate, _condition, _treatment, _isPublic);

        records[recordCount] = newRecord;
        patientRecords[msg.sender].push(recordCount);

        emit NewRecord(msg.sender, recordCount);

        recordCount++;
    }

    function getRecordCount() public view returns (uint256) {
        return recordCount;
    }

    function getRecordById(uint256 _id) public view returns (address, string memory, uint256, string memory, string memory, bool) {
        Record memory r = records[_id];
        return (r.patient, r.name, r.birthdate, r.condition, r.treatment, r.isPublic);
    }

    function getPatientRecords(address _patient) public view returns (uint256[] memory) {
        return patientRecords[_patient];
    }

    function getPublicRecords() public view returns (uint256[] memory) {
        uint256[] memory publicRecordIds = new uint256[](recordCount);
        uint256 count = 0;

        for (uint256 i = 0; i < recordCount; i++) {
            if (records[i].isPublic) {
                publicRecordIds[count] = i;
                count++;
            }
        }

        uint256[] memory result = new uint256[](count);

        for (uint256 i = 0; i < count; i++) {
            result[i] = publicRecordIds[i];
        }

        return result;
    }
}
