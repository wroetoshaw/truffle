const simplecounter=artifacts.require("./Counter.sol");
module.exports=function(deployer){
    deployer.deploy(simplecounter);
};

//truffle init 
//truffle compile
// truffle develop
//migrate
//let var = await counter.deployed();
// access var.
//const simple = artifacts.require('./');
// module.exports = function(deployer){
//     deployer.deploy(simple);
// }