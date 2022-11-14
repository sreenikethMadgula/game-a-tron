// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0;

contract Player {
    struct PlayerDetails {
        string name;
        address wallet;
    }

    mapping(address=>PlayerDetails)detailsOfPlayer;


    function getPlayerAddress(address _user) public view returns(address) {
        return detailsOfPlayer[_user].wallet;
    }

    function getPlayerName(address _user) public view returns(string memory) {
        return detailsOfPlayer[_user].name;
    }

    function getPlayerDetails(address _user) public view returns(PlayerDetails memory) {
        return detailsOfPlayer[_user];
    }
}