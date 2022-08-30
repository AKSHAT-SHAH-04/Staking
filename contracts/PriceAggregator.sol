// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract PriceAggregator {
    /**
     * Returns the latest price
     */
        function getLatestPrice(address addr) public view returns (int) {
            (
                /*uint80 roundID*/,
                int price,
                /*uint startedAt*/,
                /*uint timeStamp*/,
                /*uint80 answeredInRound*/
            ) = AggregatorV3Interface(addr).latestRoundData();
            return price/1e8;
        }

        function decimals(address addr) external view returns (uint8) {
            return AggregatorV3Interface(addr).decimals();
        }

}
