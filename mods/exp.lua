---@param e ModGetExperienceForKill
function GetExperienceForKill(e)
    local base_exp = get_base_experience(e)
    base_exp = base_exp * 0.6499999761581

    e.self:Message(MT.White, "Base:" .. base_exp)
    local multiplier = 1
    local boost_4x = e.self:GetBucket("boost_4x")
    if boost_4x == "ON" then
        multiplier = multiplier * 4
    end

    local final_exp = base_exp * multiplier

    e.self:Message(MT.Yellow, string.format("%s (%d) XP: %d, Multiplier: x%d, Before Con/Split Final: %d", e.other:GetCleanName(), e.other:GetLevel(), base_exp, multiplier, final_exp))
    e.ReturnValue = final_exp
    e.IgnoreDefault = true
    return e
end

---@param e ModGetExperienceForKill
---@return number exp
function get_base_experience(e)
    local exp = 0
    local against = e.other
    if not against.valid then
        eq.debug("Invalid mob")
        return exp
    end
    if not against:IsNPC() then
        eq.debug("Not an NPC")
        return exp
    end
    local level = against:GetLevel()
    exp = (level * level * 75 * 35 / 10) -- EXP_FORMULA
    local mod = 0
    --against:CastToNPC():GetKillExpMod() -- TODO: this isn't exposed to API?
    if mod > 0 then
        exp = exp *mod
        exp = exp / 100
    end

    return exp
end