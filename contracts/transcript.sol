//SPDX-License-Identifier:MIT
pragma solidity >=0.7.0 <0.9.0;
contract certi{
    struct Certificate{
        string regno;
        string name;
        string cc;
        uint mark;
        bool hodverify;
        bool deanverify;
    }
    mapping(address=>Certificate) public certificates;
    function faculty(string memory _re,string memory _na,string memory _cc,uint _ma)public{
        require(bytes(certificates[msg.sender].regno).length==0,"certificate already created");
        certificates[msg.sender]=Certificate(_re,_na,_cc,_ma,false,false);
    }
    function hod(address _fac) public{
        require(bytes(certificates[_fac].regno).length!=0,"certificate not exist");
        require(certificates[_fac].hodverify==false,"certificate already verified by hod");
        certificates[_fac].hodverify=true;
    }
    function dean(address _hod) public{
        require(bytes(certificates[_hod].regno).length!=0,"certificate not exist");
        require(certificates[_hod].hodverify==true,"certificate not verfied by hod");
        require(certificates[_hod].deanverify==false,"certificate already verified by dean");
        certificates[_hod].deanverify=true;
    }
    function coe(address _dean) public view returns(bool){
        require(bytes(certificates[_dean].regno).length!=0,"certificatenot exist");
        if(certificates[_dean].hodverify==true && certificates[_dean].deanverify==true){
            return true;
        }
        else{
            return false;
        }
    }
    function certificate(address _coe) public view returns(string memory,string memory,string memory,uint,bool,bool){
        return(certificates[_coe].regno, certificates[_coe].name,certificates[_coe].cc,certificates[_coe].mark,certificates[_coe].hodverify,certificates[_coe].deanverify);
    }
}