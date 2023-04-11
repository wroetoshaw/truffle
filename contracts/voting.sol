pragma solidity ^0.8.0;

contract EVoting {
    
    struct Voter {
        bool isRegistered;
        bool hasVoted;
        uint256 votedProposalId;
    }
    
    struct Proposal {
        string name;
        uint256 voteCount;
    }
    
    address public organizer;
    mapping(address => Voter) public voters;
    Proposal[] public proposals;
    
    modifier onlyOrganizer() {
        require(msg.sender == organizer, "Only the organizer can perform this action.");
        _;
    }
    
    modifier onlyRegisteredVoter() {
        require(voters[msg.sender].isRegistered, "Only registered voters can perform this action.");
        _;
    }
    
    modifier onlyUnvotedVoter() {
        require(!voters[msg.sender].hasVoted, "You have already voted.");
        _;
    }
    
    constructor(string[] memory proposalNames) {
        organizer = msg.sender;
        
        for (uint256 i = 0; i < proposalNames.length; i++) {
            proposals.push(Proposal({
                name: proposalNames[i],
                voteCount: 0
            }));
        }
    }
    
    function registerVoter(address voterAddress) public onlyOrganizer {
        voters[voterAddress].isRegistered = true;
    }
    
    function vote(uint256 proposalId) public onlyRegisteredVoter onlyUnvotedVoter {
        voters[msg.sender].hasVoted = true;
        voters[msg.sender].votedProposalId = proposalId;
        
        proposals[proposalId].voteCount++;
    }
    
    function getProposalCount() public view returns (uint256) {
        return proposals.length;
    }
    
    function getProposal(uint256 proposalId) public view returns (string memory, uint256) {
        return (proposals[proposalId].name, proposals[proposalId].voteCount);
    }
    
    function getVoterHasVoted(address voterAddress) public view returns (bool) {
        return voters[voterAddress].hasVoted;
    }
    
    function getVoterVotedProposalId(address voterAddress) public view returns (uint256) {
        return voters[voterAddress].votedProposalId;
    }
}
