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

yield("/li tp Solution")
yield("/wait 6")
    WaityWaity()
yield("/li Nexus")
yield("/wait 3")
    WaityWaity()
if tostring(Svc.ClientState.TerritoryType) == "1186" then
    yield("/vnav moveto -182.5 0.6 -31.8")
end
