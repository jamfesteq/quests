function event_combat(e)
  if (e.joined == true) then
    e.self:CastSpell(2818, 0);
    eq.depop_with_timer();
  end
end
