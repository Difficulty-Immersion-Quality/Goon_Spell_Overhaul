Ext.Osiris.RegisterListener("LevelGameplayStarted", 2, "after", function(level_name, is_editor_mode)
    for i, v in ipairs(Ext.Entity.GetAllEntitiesWithComponent("ServerCharacter")) do
        Ext.Timer.WaitFor(100, function()
            local charID = v.Uuid and v.Uuid.EntityUuid or v  -- Ensure we get the EntityUuid if available
            if type(charID) == "string" then
                Osi.AddPassive(charID, "Goon_Remove_Shillelagh_Passive")
            else
                print("Invalid character ID for AddPassive:", charID)
            end
        end)
    end
end)

-- Spell check function using regex
function Goon_Shillelagh_Check(spell)
    local match = string.match(spell, "^Shout_Shillelagh")
    return match
end

-- Listener for UsingSpellOnTarget
Ext.Osiris.RegisterListener("UsingSpellOnTarget", 6, "after", function(caster, target, spell, spellType, spellElement, storyActionID)
    if Goon_Shillelagh_Check(spell) then
        Ext.Timer.WaitFor(1000, function()
            Osi.ApplyStatus(target, "GOON_SHILLELAGH_DUMMY_UNLOCK_REMOVAL", 1, 1, caster)
        end)
    end
end)

-- Listener for status application
Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function(object, status, causee, storyActionID)
    if status == "GOON_SHILLELAGH_DUMMY_UNLOCK_REMOVAL" then
        -- Iterate through all party members
        local partyMembers = Osi.DB_PartyMembers:Get(nil)
        if partyMembers then
            for _, member in pairs(partyMembers) do
                local partyMember = member[1] -- Extract the UUID from the table entry
                if partyMember ~= object and Osi.IsPartyMember(partyMember, 1) == 1 then
                    Osi.ApplyStatus(partyMember, "GOON_SHILLELAGH_DUMMY_UNLOCK_REMOVAL_2", 1, 1, causee)
                end
            end
        end
    end
end)
