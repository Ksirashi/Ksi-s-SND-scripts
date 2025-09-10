local char = "Put your friend's name here"
local server = "Put your friend's server here"
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
    if Addons.GetAddon("TeleportHousingFriend"):GetNode(1, 6, 8, i, 5).Text == "Free Company Estate" then
        yield("/callback TeleportHousingFriend true 0")
        found = true
        break
    end
end
if not found then
                yield("/callback TeleportHousingFriend true -1")
                yield("/echo No FC found")
end
