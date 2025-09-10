    function WaityWaity()
        while 
            IPC.vnavmesh.PathfindInProgress() or 
            IPC.vnavmesh.IsRunning() or 
            IPC.Lifestream.IsBusy() or 
            Addons.GetAddon("NowLoading").Ready
        do
            yield ("/wait 0.1")
        end
    end
if tostring(Svc.ClientState.TerritoryType) ~= "478" then
    yield("/li tp Idyllshire")
    yield("/wait 6")
        WaityWaity()
end
    yield ("/wait 2")
    if not Svc.Condition[4] then
        yield("/ac Mount Roulette")
    end
    yield("/vnav moveto -17.2 206.5 48.5")
        WaityWaity()
    yield("/ac Dismount")
