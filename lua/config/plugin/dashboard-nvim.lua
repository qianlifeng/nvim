vim.g.dashboard_default_executive = 'telescope'
vim.g.dashboard_custom_footer = {''}

vim.g.dashboard_custom_section = {
    a10 = { description = { '  Projects              ' }, command = 'Telescope projects' },
    a20 = { description = { "  New                   " }, command = "DashboardNewFile" },
    a30 = { description = { '  Recently files        ' }, command = 'Telescope oldfiles' },
    a40 = { description = { '  Edit Projects         ' }, command = 'edit ~/.local/share/nvim/project_nvim/project_history' },
}

vim.g.dashboard_custom_header = {
    [[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
    [[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
    [[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
    [[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
    [[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
    [[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
}
