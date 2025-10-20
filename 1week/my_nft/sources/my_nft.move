module my_nft::my_nft;

use std::string::{String};

public struct MyNFT has key, store {
  id: UID,
  name: String,
  img_url: String
}

entry fun mint_self(name: String, img_url: String, ctx: &mut TxContext) {
  let nft = MyNFT {
    id: object::new(ctx),
    name,
    img_url
  };

  transfer::transfer(nft, ctx.sender());
}





