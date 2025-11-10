/// Module: auction_non_generic
module auction_non_generic::auction_non_generic;

use std::string::{String};

use sui::sui::{SUI};
use sui::coin::{Coin};
use sui::dynamic_field;

// Shared Object
public struct Auction<T: key + store> has key, store {
  id: UID,
  item: T,
}

// Owned Object
public struct Bid has key, store {
  id: UID,
  item_id: ID,
  bidder: address,
  coin: Coin<SUI>
}

public struct MyItem has key, store {
  id: UID,
}

// Entry Function
entry fun create_and_transfer_item(ctx: &mut TxContext) {
  let item = create_item(ctx);
  transfer::transfer(item, ctx.sender());
}

public fun create_item(ctx: &mut TxContext): MyItem {
  MyItem {
    id: object::new(ctx)
  }
}

public fun create_auction<T: key + store>(item: T, ctx: &mut TxContext) {
  let auction = Auction{
    id: object::new(ctx),
    item: item
  };

  transfer::share_object(auction);
}

public fun create_bid<T: key + store>(auction: &Auction<T>, coin: Coin<SUI>, ctx: &mut TxContext): Bid {
  Bid{
    id: object::new(ctx),
    item_id: object::id(&auction.item),
    bidder: ctx.sender(),
    coin: coin
  }
}

public fun bid<T: key + store>(auction: &mut Auction<T>, bid: Bid) {
  // auction에 있는 item의 ID와 bid의 item_id 가 다르면 abort
  assert!(object::id(&auction.item) == bid.item_id);

  let old_bid = dynamic_field::remove_if_exists<String, Bid>(&mut auction.id, b"bid_key".to_string());

  // dynamic field에서 bid_key라는 키값에 Bid가 없다면 다음 코드 실행
  if (old_bid.is_none()) {
    dynamic_field::add(&mut auction.id, b"bid_key".to_string(), bid);
    old_bid.destroy_none();
    return
  };

  // dynamic field에서 bid_key라는 키값에 none이 아니라 Bid가 있다면
  // old_bid의 실제 값 추출 및 Option 타입 없애기
  let old_bid = old_bid.destroy_some();

  if (bid.coin.value() > old_bid.coin.value()) {
    // bid의 coin 금액이 old_bid의 coin 금액보다 높다면
    // bid를 dynamic field에 넣고 old_bid는 원래 주인에게 transfer
    dynamic_field::add(&mut auction.id, b"bid_key".to_string(), bid);
    let old_recipient = old_bid.bidder;
    transfer::public_transfer(old_bid, old_recipient);
  } else {
    // old_bid의 coin 금액이 새로 제안한 bid의 coin 금액보다 높다면
    // old_bid를 다시 dynamic field에 넣고 bid는 원래 주인에게 transfer
    dynamic_field::add(&mut auction.id, b"bid_key".to_string(), old_bid);
    let recipient = bid.bidder;
    transfer::public_transfer(bid, recipient);
  };
}
