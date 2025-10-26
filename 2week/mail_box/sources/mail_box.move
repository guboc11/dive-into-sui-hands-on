module mail_box::mail_box;

use std::string::{String};

public struct House has key {
  id: UID,
  window: bool,
  door: bool,
  mail_box: vector<Mail>
}

public struct Mail has key, store {
  id: UID,
  content: String
}

public struct HouseCap has key, store {
  id: UID
}

fun init(ctx: &mut TxContext) {
  let house = House {
    id: object::new(ctx),
    window: false,
    door: false,
    mail_box: vector<Mail>[]
  };

  let house_cap = HouseCap {id: object::new(ctx)};

  transfer::share_object(house);
  transfer::transfer(house_cap, ctx.sender());
}

public fun open_window(house: &mut House) {
  house.window = true;
}

public fun close_window(house: &mut House) {
  house.window = false;
}

public fun open_door(house: &mut House, _: &HouseCap) {
  house.door = true;
}

public fun close_door(house: &mut House, _: &HouseCap) {
  house.door = false;
}

public fun put_mail_in(house: &mut House, content: String, ctx: &mut TxContext) {
  let mail = Mail { 
    id: object::new(ctx),
    content 
  };
  house.mail_box.push_back(mail);
}

public fun take_a_mail(house: &mut House, _: &HouseCap, ctx: &mut TxContext) {
  let mail = house.mail_box.pop_back();
  transfer::transfer(mail, ctx.sender());
}


