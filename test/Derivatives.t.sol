// SPDX-License-Identifier: UNLICENSED
// Your code here

pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";

import {Derivatives} from "../src/Derivatives.sol";

contract DerivativesTest is Test {
    Derivatives public derivatives;

    function setUp() public {
        derivatives = new Derivatives();
    }

    function test_it_can_deploy_without_errors() public {
        Derivatives derivativess;
        console.log("Deploying Derivatives", address(derivativess));
        Derivatives _derivatives = new Derivatives();
        assert(address(_derivatives) != address(0));
    }

    function test_user_can_check_his_initial_balance() public {
        address user = address(123);
        vm.prank(user);
        assertEq(derivatives.balance(), 0);
    }

    function test_user_can_fund_a_account() public {
        address user = address(123);
        hoax(user, 100);
        derivatives.fund{value: 100}();
        vm.prank(user);
        assertEq(derivatives.balance(), 100);
    }

    function test_its_balance_is_updated_after_funding() public {
        address user = address(123);
        hoax(user, 100);
        derivatives.fund{value: 100}();
        assertEq(address(derivatives).balance, 100);
    }

    function test_it_cannot_fund_a_account_with_zero_amount() public {
        vm.expectRevert(Derivatives.ZeroAmount.selector);
        derivatives.fund{value: 0}();
    }

    function test_user_can_withdraw_a_given_amount_from_his_account() public {
        address user = address(123);
        hoax(user, 100);
        derivatives.fund{value: 50}();
        vm.prank(user);
        derivatives.withdraw(25);
        vm.prank(user);
        assertEq(user.balance, 75);
    }

    function test_user_can_withdraw_all_his_account() public {
        address user = address(123);
        hoax(user, 100);
        derivatives.fund{value: 100}();
        vm.prank(user);
        derivatives.withdraw(100);
        vm.prank(user);
        assertEq(user.balance, 100);
        assertEq(derivatives.balance(), 0);
    }

    // cannot withdraw more than his balance

    function test_it_cannot_set_a_buyer_and_a_seller_with_the_same_address() public {
        derivatives.setBuyer(address(this));
        vm.expectRevert(Derivatives.InvalidAccount.selector);
        derivatives.setSeller(address(this));
    }

}