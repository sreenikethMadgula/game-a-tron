// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0;


contract Game {
    address owner;

    struct GameDetails {
        string name;
        uint id;
    }

    mapping(address=>mapping(uint=>uint)) minScoreForReward;

    mapping(uint=>GameDetails)detailsOfGameWithID;

    mapping(uint=>uint)highScoreOfGameWithID;

    mapping(uint=>address)highestScorerOfGameWithID;
    // mapping(uint=>address[])

    mapping(address=>mapping(uint=>uint))playerHighScoreInGameWithID;

    mapping(address=>mapping(uint=>uint[]))playerGameScores;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function getGameDetails(uint _id) public view returns(GameDetails memory) {
        return detailsOfGameWithID[_id];
    }

    function getGameHighScore(uint _id) public view returns(uint) {
        return highScoreOfGameWithID[_id];
    }

    function setGameHighScore(uint _id, uint _score) public {
        highScoreOfGameWithID[_id] = _score;
    }

    function getGameHighestScorer(uint _id) public view returns(address) {
        return highestScorerOfGameWithID[_id];
    }

    function setGameHighestScorer(uint _id, address _player) public {
        highestScorerOfGameWithID[_id] = _player;
    }

    function getPlayerHighScore(address _player, uint _gameID) public view returns(uint) {
        return playerHighScoreInGameWithID[_player][_gameID];
    }

    function setPlayerHighScore(address _player, uint _gameID, uint _score) public {
        // require(_score > getPlayerHighScore(_player,_gameID));
        playerHighScoreInGameWithID[_player][_gameID] = _score;
    }

    function getPlayerGameScores(address _player, uint _gameID) public view returns(uint[] memory) {
        return playerGameScores[_player][_gameID];
    }

    function updatePlayerGameScores(address _player, uint _gameID, uint _score) public returns(uint) {
        uint[] memory scores = playerGameScores[_player][_gameID];
        uint minScore = minScoreForReward[_player][_gameID];
        uint reward = 0;
        uint total = 0;
        uint avg;

        
        if(scores.length<20) {
            playerGameScores[_player][_gameID].push(_score);
            
        }
        else {
            for(uint i=0; i<19; i++){
                playerGameScores[_player][_gameID][i] = playerGameScores[_player][_gameID][i+1];
                total += playerGameScores[_player][_gameID][i];
            }
            total += playerGameScores[_player][_gameID][19];
            avg = total/20;
            if(_score>avg && _score>minScore) {
                reward += 5;
            }
            playerGameScores[_player][_gameID][19] = _score;
        }
        if(_score > getGameHighScore(_gameID)) {
            setGameHighScore(_gameID,_score);
            setGameHighestScorer(_gameID,_player);
            reward += 100;
        }
        if(_score > getPlayerHighScore(_player, _gameID)) {
            setPlayerHighScore(_player,_gameID,_score);
            if (_score>minScore){
                reward +=2;
            }
        }
        if(_score>minScore) {
            minScoreForReward[_player][_gameID] += 10;
        }
        return reward;
    }

    function sendReward(address payable _player) public payable {
        (bool sent, bytes memory data) = _player.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }

}