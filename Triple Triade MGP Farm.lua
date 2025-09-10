--[=====[
[[SND Metadata]]
author: `Ksirashi`
Will tp to Mor Dhona and fly up to up to Klynthota NPC and play with him until target number of MGP reached.
You will need to set up Saucy and your deck.
plugin_dependencies:
- Saucy
- Lifestream
- vnavmesh
[[End Metadata]]
--]=====]

-- ===================CONFIIIIIIIIG===================
local UserConfig = {
    targetMGP = "729241", -- Number of MGP after which the script will stop. Leave empty for infinite farm. 
    targetCards = "" -- Doesn't work for now, leave empty. Maybe will implement later
}
-- ===================CONFIIIIIIIIG===================

local MGP = UserConfig.targetMGP ~= "" and tonumber(UserConfig.targetMGP)
local Cards = UserConfig.targetCards ~= "" and tonumber(UserConfig.targetCards)

if MGP and Inventory.GetItemCount(29) >= MGP then
    yield("/echo <se.7>")
    yield("/echo You already have "..Inventory.GetItemCount(29).." MGP. Set you stuff up properly.")

    return
end

if Cards and Inventory.GetItemCount(14205) >= Cards then
    yield("/echo <se.7>")
    yield("/echo You already have "..Inventory.GetItemCount(14205).." Cards. Set you stuff up properly.")
    return
end

if not MGP and not Cards then
    yield("/echo Nothing to farm, stopping script...")
    return
end


if tostring(Svc.ClientState.TerritoryType) ~= "156" then
    yield("/li tp Revenant's Toll")
    yield("/wait 6")
        if Addons.GetAddon("NowLoading").Ready then
            while Addons.GetAddon("NowLoading").Ready do
                yield("/wait 1")
            end
        end
end

for p in luanet.each(Svc.PluginInterface.InstalledPlugins) do
    if p.InternalName == "Saucy" and not p.IsLoaded then
        Engines.Native.Run("/xlenableplugin Saucy")
        break
    end
end
        if not Svc.Condition[4] then
    yield("/ac Mount Roulette")
    yield("/wait 2")
        end
    yield("/vnav flyto 449.8 -12.2 -386.2")
    while IPC.vnavmesh.PathfindInProgress() or IPC.vnavmesh.IsRunning() do
        yield ("/wait 0.1")
    end
    yield("/ac Dismount")
    yield("/target Klynthota")
    yield("/wait 1")
    yield("/interact")
        repeat
            yield("/wait 0.1")
        until Addons.GetAddon("TripleTriadRequest").Ready
    yield("/wait 0.5")
    yield("/saucy tt go")


if MGP or Cards then
    if MGP then
        while Inventory.GetItemCount(29)<tonumber(UserConfig.targetMGP) do
--            yield("/e waiting...")
            yield("/wait 0.3")
        end
    end

--this is for future cards tracking implementation
--    if Cards then
--        while Inventory.GetItemCount(14205)<tonumber(UserConfig.targetCards) do
--            yield("/e waiting...")
--            yield("/wait 0.3")
--        end
--    end
    
    Engines.Native.Run("/xldisableplugin Saucy")
while true do
    if Addons.GetAddon("TripleTriadRequest").Ready then
        yield("/callback TripleTriadRequest true -1")
        break
    elseif Addons.GetAddon("TripleTriadResult").Ready then
        yield("/callback TripleTriadResult true -1")
        break
    end
    yield("/wait 0.2")
end
    Engines.Native.Run("/xlenableplugin Saucy")
    yield("/wait 2")
    yield("/echo <se.7>")
    yield("/e MGP farmed, my Liege!")
end
