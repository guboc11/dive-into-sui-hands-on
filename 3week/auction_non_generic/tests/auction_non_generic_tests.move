#[test_only]
module auction_non_generic::auction_non_generic_tests;
// uncomment this line to import the module
use auction_non_generic::auction_non_generic::{Auction, create_item, create_auction, create_bid, bid};

use sui::test_scenario as ts;
use sui::coin;
use sui::sui::SUI;

const ENotImplemented: u64 = 0;

#[test]
fun test_auction_non_generic() {
    // pass
    // 코인 타입 정의


    // Initialize a mock sender address
    let addr1 = @0xA;
    // Begins a multi-transaction scenario with addr1 as the sender
    let mut scenario1 = ts::begin(addr1);

    let item = create_item(scenario1.ctx());
    create_auction(item, scenario1.ctx());
    scenario1.next_tx(addr1);

    // 트레저리캡 직접 생성
    let mut cap = coin::create_treasury_cap_for_testing<SUI>(scenario1.ctx());
    // mint로 코인 생성
    let coin = coin::mint<SUI>(&mut cap, 1000, scenario1.ctx());
    transfer::public_transfer(cap, addr1);
    scenario1.next_tx(addr1);

    let mut auction = scenario1.take_shared<Auction>();
    let bid = create_bid(&auction, coin, scenario1.ctx());
    bid(&mut auction, bid);
    transfer::public_share_object(auction);
    scenario1.next_tx(addr1);

    // Cleans up the scenario object
    ts::end(scenario1);  
}

#[test, expected_failure(abort_code = ::auction_non_generic::auction_non_generic_tests::ENotImplemented)]
fun test_auction_non_generic_fail() {
    abort ENotImplemented
}
