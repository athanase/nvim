return {
    desc = "Include a description of your component",
    constructor = function(params)
        return {
            on_init = function(self, task)
                vim.cmd("wa")
            end,
        }
    end,
}
