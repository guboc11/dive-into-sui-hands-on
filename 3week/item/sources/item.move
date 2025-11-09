module item::item;

public struct MyItem has key, store {
  id: UID,
}

// Entry Function
entry fun mint_and_transfer_item(ctx: &mut TxContext) {
  let item = MyItem {
    id: object::new(ctx)
  };
  transfer::transfer(item, ctx.sender());
}

public fun mint_item(ctx: &mut TxContext): MyItem {
  MyItem {
    id: object::new(ctx)
  }
}



