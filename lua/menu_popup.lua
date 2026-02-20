local M = {}

-- Função para criar novo arquivo (cria pastas se necessário)
function M.new_file()
    -- input do usuário
    vim.ui.input({prompt = "Nome do arquivo: "}, function(input)
        if not input or input == "" then return end
        -- cria pastas pai
        vim.fn.mkdir(vim.fn.fnamemodify(input, ":h"), "p")
        -- abre arquivo
        vim.cmd("edit " .. input)
    end)
end

-- Função para mostrar menu (pode expandir para mais opções depois)
function M.show()
    local choice = vim.fn.inputlist({
        "Menu:",
        "1. Novo arquivo",
        "2. Cancelar"
    })
    if choice == 1 then
        M.new_file()
    end
end

return M

