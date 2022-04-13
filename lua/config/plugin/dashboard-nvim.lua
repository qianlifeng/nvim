vim.g.dashboard_default_executive = 'telescope'
vim.g.dashboard_custom_footer = {''}

vim.g.dashboard_custom_section = {
    a = { description = { "  New                   " }, command = "DashboardNewFile" },
    b = { description = { '  Projects              ' }, command = 'Telescope projects' },
    c = { description = { '  Recently files        ' }, command = 'Telescope oldfiles' },
    d = { description = { '  Edit Projects         ' }, command = 'edit ~/.local/share/nvim/project_nvim/project_history' },
}

vim.g.dashboard_custom_header = {
    [[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
    [[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
    [[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
    [[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
    [[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
    [[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
}
