require("autosave").setup(
    {
        enabled = true,
        events = {"InsertLeave","TextChanged"},
        execution_message = "",
        conditions = {
            exists = true,
            filename_is_not = {},
            -- 不需要自动保存的文件类型
            filetype_is_not = {"sql", "mysql"},
            modifiable = true
        },
        write_all_buffers = true,
        on_off_commands = false,
        clean_command_line_interval = 0,
        debounce_delay = 135
    }
)
