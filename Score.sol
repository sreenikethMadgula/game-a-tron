// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0;

import "./Game.sol";

// contract Score {
//     address owner;

//     Game game;

//     modifier onlyOwner() {
//         require(msg.sender == owner);
//         _;
//     }

//     constructor() {
//         owner = msg.sender;
//         game = new Game(owner);
//     }

//     mapping(address=>mapping(uint=>uint[]))playerGameScores;

//     function getGameContract() public view returns(address) {
//         return address(game);
//     }

//     function getPlayerGameScores(address _player,uint _gameID) public view returns (uint[] memory) {
//         return playerGameScores[_player][_gameID];
//     }

//     function updatePlayerGameScores(address _player, uint _gameID, uint _score) public {
//         uint[] memory score = playerGameScores[_player][_gameID];
//         uint total = 0;
//         uint avg;
//         if(score.length<20) {
//             playerGameScores[_player][_gameID].push(_score);
//         }
//         else {
//             for(uint i=0; i<19; i++){
//                 playerGameScores[_player][_gameID][i] = playerGameScores[_player][_gameID][i+1];
//                 total += playerGameScores[_player][_gameID][i];
//             }
//             total += playerGameScores[_player][_gameID][19];
//             avg = total/20;
//             // if(_score>avg) {
//             //     rewardPlayer(_player);
//             // }
//             playerGameScores[_player][_gameID][19] = _score;
//         }

//     }

//     // function rewardPlayer(address _player) public {}

// }

contract Score {
    address owner;

    Game game;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    constructor() {
        owner = msg.sender;
        game = new Game(owner);
    }

    mapping(address=>mapping(uint=>uint[]))playerGameScores;

    function getGameContract() public view returns(address) {
        return address(game);
    }

    function getPlayerGameScores(address _player, uint _gameID) public view returns(uint[] memory) {
        return playerGameScores[_player][_gameID];
    }

    function updatePlayerGameScores(address _player, uint _gameID, uint _score) public {
        uint[] memory scores = playerGameScores[_player][_gameID];
        uint total = 0;
        uint avg;
        // for(uint i=0; i<scores.length; i++){
        //     total+=playerGameScores[_player][_gameID][i];
        // }
        // avg = total/scores.length;
        
        if(scores.length<20) {
            // for(uint i=0; i<scores.length; i++){
            //     total+=playerGameScores[_player][_gameID][i];
            // }
            // avg = total/scores.length;
            playerGameScores[_player][_gameID].push(_score);
        }
        else {

            for(uint i=0; i<19; i++){
                playerGameScores[_player][_gameID][i] = playerGameScores[_player][_gameID][i+1];
                total += playerGameScores[_player][_gameID][i];
            }
            total += playerGameScores[_player][_gameID][19];
            avg = total/20;
            // if(_score>avg) {
            //     rewardPlayer(_player);
            // }
            playerGameScores[_player][_gameID][19] = _score;
        }
        if(_score > game.getGameHighScore(_gameID)) {
            game.setGameHighScore(_gameID,_score);
        }
        if(_score > game.getPlayerHighScore(_player, _gameID)) {
            game.setPlayerHighScore(_player,_gameID,_score);
        }
    }

    // function rewardPlayer(address _player) public {}

}