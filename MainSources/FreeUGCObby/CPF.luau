local cpf = {}

function cpf.getSortedCheckpoints()
    local folder = workspace:WaitForChild("Checkpoints")
    local list = {}

    for _, obj in ipairs(folder:GetChildren()) do
        local num = tonumber(obj.Name)
        if num then
            table.insert(list, {
                number = num,
                instance = obj
            })
        end
    end

    table.sort(list, function(a, b)
        return a.number < b.number
    end)

    return list
end

return cpf

