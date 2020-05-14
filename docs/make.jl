using Documenter, SLIMutils

makedocs(
    sitename = "SLIMutils Reference",
    modules = [SLIMutils]
)

deploydocs(
    repo = "github.com/slimgroup/SLIMutils.jl.git"
)
