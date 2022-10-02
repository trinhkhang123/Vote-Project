pragma solidity ^0.8.0;

contract Vote {

    mapping (address => bool) Checkvoted;

    mapping(address => uint ) Id;

    mapping (address => uint) balances;

    mapping (uint => address) ListNominee;

    mapping (address => bool) CheckNominee; 



    address Admin ;

    uint TotalID = 0;

    uint TotalNominee = 0;

    constructor () public {
        Admin = msg.sender;
    }

    function AddNominee (address Nominee) public returns (bool) {
        require(msg.sender == Admin,"You are not an administrator");
        TotalNominee ++ ;
        ListNominee[TotalNominee] = Nominee;
        CheckNominee[Nominee] = true;
        return true;
    }

     function Register(address AddrVoter) public returns (bool) {
        require(Id[AddrVoter] == 0,"You are regisrtered");
        require(msg.sender == Admin,"You are not an administrator");
        TotalID ++;
        Id[AddrVoter] = TotalID; 
        return true;
    }

    modifier checkNominee (address Nominee) {
            require(CheckNominee[Nominee]== true, "You are not a Nominee");
            _;
    }

  
    modifier CheckVoted (address AddrVoter) {
        require(Checkvoted[AddrVoter]== false, "You voted");
        _;
    }

    modifier CheckId (address AddrVoter) {
        require(Id[AddrVoter]>0, "you are not registered");
        _;
    }

    function Votee( address AddrNominee) public virtual checkNominee(AddrNominee) CheckVoted(msg.sender) CheckId (msg.sender) returns (bool) {
        balances[AddrNominee] ++;
        Checkvoted[msg.sender] = true;
        return true;
    }

    function Balance (address Nominee) public view returns (uint) {
        return balances[Nominee];
    }

    function check (address Voter) public view returns (bool) {
        return Checkvoted[Voter];
    }

    function ID (address Voter) public view returns (uint) {
        return Id[Voter];
    }

     function IDD () public view returns (address) {
        return Admin;
    }
}