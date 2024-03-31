--- @param e PlayerEventCommand
local function boost_mighty(e)
    local boost_mighty = e.self:GetBucket("boost_mighty")
    if boost_mighty == "ON" then
        boost_mighty = "OFF"
    else
        boost_mighty = "ON"
    end
    e.self:SetBucket("boost_mighty", boost_mighty)
    e.self:Message(MT.Say, "Mighty combat boost is now " .. boost_mighty .. ", giving you 2x outgoing damage and significant reduction in incoming damage.")
end

return boost_mighty;