module my_nft::my_nft;

use std::string::{String};
use sui::package;
use sui::display;

public struct MY_NFT has drop {}

public struct MyNFT has key, store {
  id: UID,
  name: String,
  image_url: String
}

fun init(otw: MY_NFT, ctx: &mut TxContext) {
    let keys = vector[
        b"name".to_string(),
        b"image_url".to_string(),
    ];

    let values = vector[
        b"{name}".to_string(),
        b"{image_url}".to_string(),
    ];

    let publisher = package::claim(otw, ctx);
    let mut display = display::new_with_fields<MyNFT>(
        &publisher, keys, values, ctx
    );

    display.update_version();

    transfer::public_transfer(publisher, ctx.sender());
    transfer::public_transfer(display, ctx.sender());
}

entry fun mint_self(name: String, image_url: String, ctx: &mut TxContext) {
  let nft = MyNFT {
    id: object::new(ctx),
    name,
    image_url
  };

  transfer::transfer(nft, ctx.sender());
}





