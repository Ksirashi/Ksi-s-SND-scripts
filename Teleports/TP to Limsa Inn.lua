--It only works if your GC is Malestorm and it will use Malestorm tickets

local zoneID = Svc.ClientState.TerritoryType

if Inventory.GetItemCount(21069)>0
    then
        if tostring(zoneID) ~= "128" then
            yield("/item Maelstrom Aetheryte Ticket")
            yield("/wait 6")
                if Addons.GetAddon("NowLoading").Ready then
                    while Addons.GetAddon("NowLoading").Ready do
                        yield("/wait 1")
                end
        end
end
yield("/vnav moveto 12, 40, 12")
    while IPC.vnavmesh.PathfindInProgress() or IPC.vnavmesh.IsRunning() do
        yield ("/wait 0.1")
    end
yield("/target Mytesyn")
yield("/interact")
else 
    yield("/li inn")
end
