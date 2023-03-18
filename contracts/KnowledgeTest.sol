//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract KnowledgeTest {

    string[] public tokens = ["BTC", "ETH"];
    address[] public players;

    // state variabel untuk menyimpan address wallet
    address public owner;

    constructor(){
        // initiate wallet pertama ketika connect ke contract ini
        // masukan state variable owner dengan address wallet user
        owner = msg.sender;
    }

    // fungsi receive dan fallback dengan modifier payable digunakan untuk transaksi pada ethereum
    // tanpa ini, fungsi yang memerlukan tranksaksi akan error
    receive() external payable {}
    fallback () external payable {}

    // ubah state variable
    // karena ubah state variable, maka ada gas fee
    function changeTokens() public {
        tokens[0] = "VET";
    }

    // mendapatkan info ether pada wallet
    // view artinya read-only, karena kita hanya baca token di blockchain
    function getBalance() public view returns (uint){
        return address(this).balance;
    }

    // melakukan transfer dengan pengecekan hanya jika alamat wallet adalah milik owner yg ada di kontrak
    // transfer semua balance owner ke receiver
    function transferAll(address receiver) public {
        require(msg.sender == owner, "ONLY_OWNER");
        payable(receiver).transfer(getBalance());
    }

    // fungsi sederhana untuk menggabungkan 2 string
    // tidak ada hubunganya dengan blockchain, makanya diberikan keyword pure
    // calldata dan memory artinya data tidak disimpan di blockchain
    function concatenate(string calldata a, string calldata b) public pure returns(string memory){
        return string.concat(a,b);
    }

    // memasukan address wallet ke state variable
    // karena ubah state maka kena gas fee
    function start() public {
        players.push(msg.sender);
    }
}
