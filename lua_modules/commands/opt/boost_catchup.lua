--- @param e PlayerEventCommand
local function boost_catchup(e)
    local boost_catchup = e.self:GetBucket("boost_catchup")
    if boost_catchup == "ON" then
        boost_catchup = "OFF"
    else
        boost_catchup = "ON"
    end
    e.self:SetBucket("boost_catchup", boost_catchup)
    e.self:Message(MT.Say, "Experience catchup boost is now " .. boost_catchup .. ", giving you a 10x to 28x curved exp boost.")
end

return boost_catchup;