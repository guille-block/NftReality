pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/** 
 * @title ERC20 token rewards for Reality NFT
 * @author Guillermo Fairbairn
 * @notice You can use this contract to get token rewards for your minted reality nfts, depending the type of NFT
 * you have ('Fire', 'Air', 'Water', 'Earth') you get a different reward
 * @dev Will mint reward on nft transfer coming only from realityPointer
*/
contract RealityReward is ERC721Holder, ERC20 {
    
    address private _realityPointer;
    
    constructor(address _realityContract) 
        ERC20("RealityNFTCoin", "RNFT") 
    {
        _realityPointer = _realityContract;
    }

    function onERC721Received(
        address operator, 
        address from , 
        uint256 tokenId, 
        bytes memory data
    ) 
        public override returns (bytes4) 
    {
        require(msg.sender == _realityPointer);
        _mintReward(from, tokenId);
        return this.onERC721Received.selector;    
    }

    function realityPointer() 
        public view 
        returns(address)
    {
        return _realityPointer;
    }

    /** 
     * @author Guillermo Fairbairn
     * @param _from The address transfering the nft
     * @param _tokenId The Id of the nft being transfered
     * @dev Calculates which reward should be minted depending on the type of reality nft
    */
    function _mintReward(
        address _from, 
        uint256 _tokenId
    ) 
        private 
    {
        (bool success, bytes memory data) = _realityPointer.call(abi.encodeWithSignature('_realities(uint256)', 
                                                                                         _tokenId));
        if(keccak256(bytes(abi.decode(data, (string)))) == keccak256(bytes('Fire'))) {
            uint256 _retorno = 5 * 10 ** 9;
            _mint(_from, _retorno);
        } else if (keccak256(bytes(abi.decode(data, (string)))) == keccak256(bytes('Air'))) { 
            uint256 _retorno = 2 * 10 ** 7;
            _mint(_from, _retorno);
        } else if (keccak256(bytes(abi.decode(data, (string)))) == keccak256(bytes('Earth'))) {
            uint256 _retorno = 8 * 10 ** 5;
            _mint(_from, _retorno);
        } else {
             uint256 _retorno = 9 * 10 ** 3;
            _mint(_from, _retorno);
        }
    }
}