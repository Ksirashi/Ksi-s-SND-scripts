--THIS ONE NOT FINISHED! Need to put the room number manually for now. 
--It's in the yield("/callback MansionSelectRoom true 0 3") line at the very bottom

local char = "Put your fiend's name here"
local server = "Pur your friend's server here"
local currentserver = Addons.GetAddon("_DTR"):GetNode(1, 2, 4).Text

  function LoadingWait()
      repeat
          yield("/wait 2")
      until Player.Available
  end

  function LifestreamWait()
      while IPC.Lifestream.IsBusy() == true do
          yield("/wait 2")
  end
  end

if server ~= currentserver then
    yield("/li "..server)
    yield("/wait 6")
        LifestreamWait()
        LoadingWait()
end

yield("/estatelist "..char)
repeat
    yield("/wait 0.1")
until Addons.GetAddon("TeleportHousingFriend").Ready
    yield("/wait 0.2")

local ids = {2, 21001, 21002}
for _, i in ipairs(ids) do
    if Addons.GetAddon("TeleportHousingFriend"):GetNode(1, 6, 8, i, 5).Text == "Apartments" then
        yield("/callback TeleportHousingFriend true 2")
        found = true
        break
    end
end
if not found then
                yield("/callback TeleportHousingFriend true -1")
                yield("/echo No Appartments found")
end
    yield("/wait 6")
        LifestreamWait()
        LoadingWait()
    Entity.GetEntityByName("Apartment Building Entrance"):SetAsTarget()
    yield("/wait 0.5")
    yield("/vnav movetarget")
    while Entity.Target.DistanceTo > 3 do
        yield("/wait 0.1")
    end
    Entity.GetEntityByName("Apartment Building Entrance"):Interact()
        yield("/waitaddon SelectString")
        yield("/callback SelectString true 0")
        yield("/waitaddon MansionSelectRoom")
        yield("/callback MansionSelectRoom true 0 3")
        yield("/waitaddon SelectYesno")
        yield("/callback SelectYesno true 0")
