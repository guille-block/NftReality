pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract Realities is ERC721URIStorage {

    using Counters for Counters.Counter;

    mapping(uint256 => string) public _realities;
    
    Counters.Counter private _tokenIds;
    string[4] private elements = ['Air','Water','Earth','Fire'];
    
    constructor() 
        ERC721("Realities", "NFT") 
    {}

    /**
     * @author Guillermo Fairbairn
     * @notice Mint Reality nft and assign an element type to it.
     * @dev As the contract has been developed, the use of _setTokenURI()
     * is irrelevant
     * @return Id of the minted nft
     */
    function getReality(
        string memory tokenURI
    ) 
        public returns (uint256) 
    {
        uint8 typeOfReality = _randElement();
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _realities[newItemId] = elements[typeOfReality];
        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURI);

        return newItemId;
    }

    /**
     * @author Guillermo Fairbairn
     * @notice Get random number between 0 and 3 to determine the type
     * of reality to be minted
     * @dev Random function should be replaced by call to 
     * an Oracle for random number (E.g ChainLink, Dia, Band)
     * @return Type of reality 
     */
    function _randElement() 
        private returns(uint8) 
    { 
        bytes32 bitRandom = keccak256(abi.encodePacked(block.timestamp));
        uint256 random = uint(bitRandom);
        uint8 typeOfReality = uint8(random % 4);
        return typeOfReality;
     }

}