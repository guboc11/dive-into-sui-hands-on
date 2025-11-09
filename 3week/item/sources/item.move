module item::item;

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



