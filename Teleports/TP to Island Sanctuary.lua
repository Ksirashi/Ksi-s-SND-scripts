yield("/tp Moraby Drydocks")
yield("/wait 6")
      repeat
          yield("/wait 2")
      until Player.Available
yield("/wait 1")
yield("/target Baldin")
yield("/wait 1")
yield("/vnav movetarget")
    while Entity.Target.DistanceTo>1 do
        yield ("/wait 0.1")
    end
yield("/interact")
