// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0;

contract Game {
    struct GameDetails {
        string name;
        uint id;
    }
    mapping(uint=>GameDetails)detailsOfGameWithID;

    mapping(uint=>uint)highScoreOfGameWithID;

    mapping(uint=>address)highestScorerOfGameWithID;
    // mapping(uint=>address[])

    mapping(address=>mapping(uint=>uint))playerHighScoreInGameWithID;

    function getGameDetails(uint _id) public view returns(GameDetails memory) {
        return detailsOfGameWithID[_id];
    }

    function getGameHighScore(uint _id) public view returns(uint) {
        return highScoreOfGameWithID[_id];
    }

    function getGameHighestScorer(uint _id) public view returns(address) {
        return highestScorerOfGameWithID[_id];
    }

    function getPlayerHighScoreInGame(address _player, uint _gameID) public view returns(uint) {
        return playerHighScoreInGameWithID[_player][_gameID];
    }
}