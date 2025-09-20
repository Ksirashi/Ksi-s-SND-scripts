--updated a very old script someone made for old SND from times before GBR, and rewritten by me like 3 times at this point, so I can almost say that it's mine :D
--basically only useful for Cosmic, or if for some reason you can't or don't want to use GBR.
--Reaches 1000 collectability and then restores as much integrity as GP allow. Needs at least 700 GP, preferably 970 GP. 
--Has also a no GP rotation, but it's optimized for ephemeral nodes, not for Cosmic. Will rework it too at some point.

--[[SND Metadata]]
author: Ksirashi (Eclipse)
version: 4.0
description: Does collectables rotation for Cosmic.
--[[End Metadata]]

if Player.Job.Id == 17 then
 action_name_one_more = "Ageless Words"
 action_name_meticulous = "Meticulous Woodsman"
elseif Player.Job.Id == 16 then
 action_name_one_more = "Solid Reason"
 action_name_meticulous = "Meticulous Prospector"
end

function action(action_name)
  yield("/action \""..action_name.."\"")
  yield("/wait 1")
  while Svc.Condition[42] do
    yield("/wait 0.2")
  end
  yield("/wait 0.5")
end

function HasStatus(id)
    local statuses = Player.Status
    for i = 0, 29 do
        local status = statuses[i]
        if status and status.StatusId == id then
            return true
        end
    end
    return false
end

function current_coll()
  return tonumber(Addons.GetAddon("GatheringMasterpiece"):GetNode(1, 37, 42, 47).Text)
end

function actions_left()
  return tonumber(Addons.GetAddon("GatheringMasterpiece"):GetNode(1, 73, 119, 126).Text)
end

function collect_all()
  while(actions_left() > 0) and Addons.GetAddon("GatheringMasterpiece").Ready do
    yield("/echo Actions left: "..actions_left())
    action("Collect")
if actions_left() == 1 and Svc.ClientState.LocalPlayer.CurrentGp > 299 then 
  action(action_name_one_more)
  if HasStatus(2765) then
    action("Wise to the World")
  end
end
  end
end

function full_loop()
  yield("/echo Doing high GP gathering loop...")
  action("Scrutiny")
  action(action_name_meticulous)
  action("Scrutiny")
  action(action_name_meticulous)
  if current_coll() == 1000 then
    action("Collect")
  elseif current_coll() > 800 then
    action(action_name_meticulous)
  else
    action("Scour")
  end
  action(action_name_one_more)
  if current_coll() < 1000 then
    action(action_name_meticulous)
  end

  if HasStatus(2765) then
    if actions_left() > 3 then
      action("Collect")
    end
    action("Wise to the World")
  end
  collect_all()
end

function limited_loop()
  yield("/echo Doing low GP loop...")
  action("Scour")
  action(action_name_meticulous)
  action(action_name_meticulous)
  if current_coll() < 570 then
    action(action_name_meticulous)
  end
  collect_all()
end

function main()
  while not Addons.GetAddon("GatheringMasterpiece").Ready do
--    yield("/echo Waiting for node...")
    yield("/wait 1")
  end

  yield("/echo At node.")
  yield("/echo Current GP: "..Svc.ClientState.LocalPlayer.CurrentGp)

  if Svc.ClientState.LocalPlayer.CurrentGp > 700 then
    full_loop()
  else
    limited_loop()
  end
  yield("/echo Done gathering!")
  yield("/wait 3")
end

while true do
    local status, error = pcall(main)
    if not status then
--        yield("/echo Error occurred: " .. tostring(error))
        yield("/wait 1")
    end
    yield("/wait 0.1")
end
