// SPDX-License-Identifier:MIT
pragma solidity ^0.8.13;

import "../erc20/ERC20.sol";

contract token is ERC20 {
    uint32 public time = uint32(block.timestamp);
    uint112 public constant max_token_number = 3780000000000000000;
    uint112 public constant all_claim = max_token_number / 2;
    uint16 the_number_of_claim = 0;

    mapping(address => bool) public is_claim;

    constructor() ERC20("name", "kenny") {
        _mint(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4, max_token_number / 2);
    }

    function claim() public {
        require(msg.sender == tx.origin);
        if (
            block.timestamp - time <= 360 days &&
            return_is_claim(msg.sender) == false
        ) {
            the_number_of_claim += 1;
            is_claim[msg.sender] = true;
            _mint(msg.sender, return_claim_number());
        }
    }

    function return_claim_number() public view returns (uint112) {
        uint112 claim_number;
        if (the_number_of_claim <= 1010) {
            claim_number = (((all_claim / 100) * 20) / 1010) * 1;
        } else if (
            the_number_of_claim > 1010 && the_number_of_claim <= 101010
        ) {
            claim_number = (((all_claim / 100) * 80) / 101010) * 1;
        }
        return claim_number;
    }

    function return_is_claim(address _address) public view returns (bool) {
        return is_claim[_address];
    }
}
