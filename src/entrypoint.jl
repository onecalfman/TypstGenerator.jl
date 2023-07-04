
gen_header(title::String, authors::Vector{String})::String = """
#let project(title, doc) = {
set document(author: ($(join(map(x -> "\"$(x)\"",authors), ", "))), title: title)
doc
}
#show: project.with("$title")
	"""

TypstElements = Union{AbstractTypst, Vector{AbstractTypst}, Vector{TypstBaseElement}}

function typst(content::T; title::E = "None", authors::Vector{S} = ["None"]) where {T <: TypstElements, E <: AbstractString, S <: AbstractString}
    gen_header(string(title), string.(authors)) * render(content, create_context(true))
end