--- @param e PlayerEventCommand
local function boost_mighty(e)
    local boost_mighty = e.self:GetBucket("boost_mighty")
    if boost_mighty == "ON" then
        boost_mighty = "OFF"
    else
        boost_mighty = "ON"
    end
    e.self:SetBucket("boost_mighty", boost_mighty)
    e.self:Message(15, "Mighty combat boost is now " .. boost_mighty)
end

return boost_mighty;