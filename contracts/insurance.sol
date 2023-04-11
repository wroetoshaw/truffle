pragma solidity ^0.8.0;

contract InsuranceClaims {
    
    struct Claim {
        uint256 id;
        address payable claimant;
        string reason;
        uint256 amount;
        bool approved;
    }
    
    mapping (uint256 => Claim) public claims;
    uint256 public claimCount;
    
    address public owner;
    uint256 public premium;
    
    event ClaimFiled(uint256 indexed id, address indexed claimant, string reason, uint256 amount);
    event ClaimApproved(uint256 indexed id, address indexed claimant, uint256 amount);
    event ClaimRejected(uint256 indexed id, address indexed claimant, string reason);
    
    constructor(uint256 _premium) {
        owner = msg.sender;
        premium = _premium;
    }
    
    function fileClaim(string memory _reason, uint256 _amount) public payable {
        require(msg.value == premium, "Please pay the premium amount to file a claim");
        claimCount++;
        claims[claimCount] = Claim(claimCount, payable(msg.sender), _reason, _amount, false);
        emit ClaimFiled(claimCount, msg.sender, _reason, _amount);
    }
    
    function approveClaim(uint256 _id) public {
        require(msg.sender == owner, "Only the contract owner can approve claims");
        require(claims[_id].claimant != address(0), "Invalid claim ID");
        require(!claims[_id].approved, "Claim has already been approved");
        claims[_id].approved = true;
        claims[_id].claimant.transfer(claims[_id].amount);
        emit ClaimApproved(_id, claims[_id].claimant, claims[_id].amount);
    }
    
    function rejectClaim(uint256 _id, string memory _reason) public {
        require(msg.sender == owner, "Only the contract owner can reject claims");
        require(claims[_id].claimant != address(0), "Invalid claim ID");
        require(!claims[_id].approved, "Claim has already been approved");
        claims[_id].claimant.transfer(premium);
        emit ClaimRejected(_id, claims[_id].claimant, _reason);
    }
    
    function withdrawFunds() public {
        require(msg.sender == owner, "Only the contract owner can withdraw funds");
        payable(msg.sender).transfer(address(this).balance);
    }
    
}
